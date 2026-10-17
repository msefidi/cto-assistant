#!/bin/zsh
# Run a native BigQuery SQL statement through the Metabase REST API and print TSV.
# usage: tools/mbq.sh "SELECT ..."          (or: tools/mbq.sh -f query.sql)
# Metabase database 2 = "Bigquery (fomf-dl)". Key: METABASE_API_KEY in cto-assistant/.env (never echo it).
# Use this when gcloud/bq auth is expired; prefer read-only bq when it works.
set -e
ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
KEY=$(grep METABASE_API_KEY "$ROOT/.env" | cut -d= -f2- | tr -d '"' | tr -d "'")
[ -z "$KEY" ] && { echo "METABASE_API_KEY missing in $ROOT/.env — ask Mahyar to re-add it" >&2; exit 1; }
if [ "$1" = "-f" ]; then BODY=$(jq -n --rawfile q "$2" '{database:2, type:"native", native:{query:$q}}');
else BODY=$(jq -n --arg q "$1" '{database:2, type:"native", native:{query:$q}}'); fi
curl -s -X POST https://fomf2.metabaseapp.com/api/dataset -H "x-api-key: $KEY" -H "Content-Type: application/json" -d "$BODY" \
 | jq -r 'if .error then "ERROR: "+.error else ((.data.cols|map(.name)|@tsv), (.data.rows[]|@tsv)) end'
