#!/bin/zsh
# Google Search Console (Search Analytics API) helper. Read-only.
#
# Auth: application-default credentials with the webmasters.readonly scope:
#   gcloud auth application-default login --scopes=openid,https://www.googleapis.com/auth/userinfo.email,https://www.googleapis.com/auth/cloud-platform,https://www.googleapis.com/auth/webmasters.readonly
# Quota project: fomf-dl (searchconsole.googleapis.com enabled there on 22 Sep 2026);
# override with GSC_QUOTA_PROJECT=...
#
# usage:
#   tools/gsc.sh sites
#   tools/gsc.sh query <site> <start> <end> <dimensions> [page-regex] [query-regex]
#     site        e.g. sc-domain:fomf.de  or  https://www.fomf.de/
#     dimensions  comma list of date,page,query,country,device
#     page-regex  optional RE2 regex on the page URL (e.g. 'syfat')
#     query-regex optional RE2 regex on the search query (e.g. 'facharzt')
#   Output: TSV (dimensions..., clicks, impressions, ctr, position). Paginates past 25,000 rows.
set -e
TOKEN=$(gcloud auth application-default print-access-token 2>/dev/null) || { echo "no ADC token: run the login command in the header of this script" >&2; exit 1; }
QP=${GSC_QUOTA_PROJECT:-fomf-dl}
H=(-H "Authorization: Bearer $TOKEN" -H "Content-Type: application/json" -H "x-goog-user-project: $QP")
API=https://searchconsole.googleapis.com/webmasters/v3

case "$1" in
  sites)
    curl -s "$API/sites" "${H[@]}" | jq -r 'if .error then "ERROR: "+.error.message else (.siteEntry[]? | [.siteUrl,.permissionLevel] | @tsv) end' ;;
  query)
    SITE=$2; START=$3; END=$4; DIMS=$5; PAGE_RE=$6; QUERY_RE=$7
    ENC_SITE=$(python3 -c 'import sys,urllib.parse;print(urllib.parse.quote(sys.argv[1],safe=""))' "$SITE")
    FILTERS='[]'
    [ -n "$PAGE_RE" ]  && FILTERS=$(jq -n --arg re "$PAGE_RE"  '[{dimension:"page", operator:"includingRegex", expression:$re}]')
    [ -n "$QUERY_RE" ] && FILTERS=$(echo "$FILTERS" | jq --arg re "$QUERY_RE" '. + [{dimension:"query", operator:"includingRegex", expression:$re}]')
    START_ROW=0; FIRST=1
    while :; do
      BODY=$(jq -n --arg s "$START" --arg e "$END" --arg d "$DIMS" --argjson f "$FILTERS" --argjson sr $START_ROW \
        '{startDate:$s,endDate:$e,dimensions:($d|split(",")),rowLimit:25000,startRow:$sr,dataState:"final",
          dimensionFilterGroups:(if ($f|length)>0 then [{filters:$f}] else [] end)}')
      RES=$(curl -s -X POST "$API/sites/$ENC_SITE/searchAnalytics/query" "${H[@]}" -d "$BODY")
      echo "$RES" | jq -e '.error' >/dev/null 2>&1 && { echo "ERROR: $(echo "$RES" | jq -r '.error.message')" >&2; exit 1; }
      N=$(echo "$RES" | jq '.rows|length')
      [ $FIRST = 1 ] && { echo "$DIMS" | tr ',' '\t' | sed 's/$/\tclicks\timpressions\tctr\tposition/'; FIRST=0; }
      echo "$RES" | jq -r '.rows[]? | (.keys + [.clicks,.impressions,.ctr,.position]) | @tsv'
      [ "$N" -lt 25000 ] && break
      START_ROW=$((START_ROW+25000))
    done ;;
  *) sed -n '2,20p' "$0"; exit 1 ;;
esac
