#!/usr/bin/env bash
# SessionStart hook: prints Mahyar's board (Linear team CTO) into the session context.
# Lists every open issue and every issue changed since the last session that ran this hook.
# The Linear personal API key lives in GCP Secret Manager (secret cto-assistant-linear-api-key in
# project fomf-common), so every machine gets it. Each machine caches it as LINEAR_API_KEY in the
# git-ignored .env at the repo root, so a session start needs no gcloud call and still works when the
# gcloud login has expired. If Linear rejects the cached key, the script fetches it again (key rotation).
# Test with a saved API response: .claude/hooks/linear-board.sh <response.json>
# Never fails the session: any problem is printed as one line and the script exits 0.

ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
STATE="$ROOT/.claude/linear-board.last"
NOW="$(date -u +%Y-%m-%dT%H:%M:%S.000Z)"
LAST="$(cat "$STATE" 2>/dev/null || echo "")"

if [ -n "${1:-}" ]; then
  RESPONSE="$(cat "$1")"
else
  SECRET=cto-assistant-linear-api-key
  GCP_PROJECT=fomf-common
  ENV="$ROOT/.env"
  cached_key() { grep -E '^LINEAR_API_KEY=' "$ENV" 2>/dev/null | tail -1 | cut -d= -f2- | tr -d '"'"'"' \r'; }
  fetch_key() {
    local k
    k="$(gcloud secrets versions access latest --secret="$SECRET" --project="$GCP_PROJECT" --quiet 2>/dev/null)"
    if [ -n "$k" ]; then
      { grep -vE '^LINEAR_API_KEY=' "$ENV" 2>/dev/null; printf 'LINEAR_API_KEY=%s\n' "$k"; } > "$ENV.tmp" \
        && mv "$ENV.tmp" "$ENV"
    fi
    printf '%s' "$k"
  }
  query() {
    curl -sS --max-time 8 https://api.linear.app/graphql -H "Content-Type: application/json" \
      -H @<(printf 'Authorization: %s\n' "$1") \
      -d '{"query":"{ issues(first: 200, filter: {team: {key: {eq: \"CTO\"}}}) { nodes { identifier title dueDate updatedAt state { name type } labels { nodes { name } } parent { identifier } assignee { name } } } }"}' 2>&1
  }
  KEY="$(cached_key)"; FROM=cache
  [ -z "$KEY" ] && { KEY="$(fetch_key)"; FROM=gcp; }
  if [ -z "$KEY" ]; then
    echo "Board sync skipped: no LINEAR_API_KEY in .env and Secret Manager could not be read (secret $SECRET in $GCP_PROJECT; gcloud login expired or secret missing). Read the board with the Linear connector (list_issues, team CTO) instead, and tell Mahyar."
    exit 0
  fi
  RESPONSE="$(query "$KEY")"
  if [ "$FROM" = cache ] && printf '%s' "$RESPONSE" | grep -q AUTHENTICATION_ERROR; then
    KEY="$(fetch_key)"; [ -n "$KEY" ] && RESPONSE="$(query "$KEY")"
  fi
fi

OUT="$(printf '%s' "$RESPONSE" | jq -r --arg last "$LAST" --arg now "$NOW" '
  if .errors or (.data.issues.nodes | not) then
    "Board sync failed: " + ((.errors // [{"message":"unexpected response"}]) | map(.message) | join("; ")) + ". Read the board with the Linear connector instead."
  else
    .data.issues.nodes as $all
    | def line: "- \(.identifier) [\(.state.name)] \(.title)"
        + (if .dueDate then " · due \(.dueDate)" else "" end)
        + (if (.labels.nodes | length) > 0 then " · " + (.labels.nodes | map(.name) | join(", ")) else "" end)
        + (if .parent then " · sub-issue of \(.parent.identifier)" else "" end);
    ($all | map(select(.state.type | IN("completed", "canceled", "duplicate") | not))
          | sort_by(.dueDate // "9999-12-31")) as $open
    | ($all | map(select($last != "" and .updatedAt > $last)) | sort_by(.updatedAt) | reverse) as $changed
    | "## Board (Linear team CTO), read \($now)\n"
      + "Sync rule (AGENTS.md, Board): write into the matching topic brief whatever Mahyar changed here.\n\n"
      + (if $last == "" then "First run: no earlier session to compare with.\n"
         elif ($changed | length) == 0 then "No issue changed since the last session (\($last)).\n"
         else "### Changed since the last session (\($last))\n" + ($changed | map(line) | join("\n")) + "\n" end)
      + "\n### Open (\($open | length))\n" + ($open | map(line) | join("\n"))
  end' 2>&1)"

if [ $? -ne 0 ] || [ -z "$OUT" ]; then
  echo "Board sync failed: could not read the Linear response. Read the board with the Linear connector instead."
  exit 0
fi

printf '%s\n' "$OUT"
case "$OUT" in "## Board"*) [ -z "${1:-}" ] && echo "$NOW" > "$STATE" ;; esac
exit 0
