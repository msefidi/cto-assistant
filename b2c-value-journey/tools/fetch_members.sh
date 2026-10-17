#!/bin/zsh
# Re-extract the per-member dataset for all cohorts and regenerate data/members_compact.json.
# Runs sql/cohort_member_rows_all_months.sql in cohort chunks of ~3 months (Metabase caps a result at 2000 rows),
# merges them into data/cohort_member_rows_all_months.json, then compacts to the array format the page embeds.
# Requires: jq, curl, METABASE_API_KEY in cto-assistant/.env. Takes about a minute.
# Verified 2026-09-20: output identical to the embedded data as a set (row order within a day was not deterministic before the ORDER BY fix).
set -e
cd "$(dirname "$0")/.."
KEY=$(grep METABASE_API_KEY ../.env | cut -d= -f2- | tr -d '"' | tr -d "'")
[ -z "$KEY" ] && { echo "METABASE_API_KEY missing in ../.env" >&2; exit 1; }
TMP=$(mktemp -d); i=0
CHUNKS=("'2024-08','2024-09','2024-10'" "'2024-11','2024-12','2025-01'" "'2025-02','2025-03','2025-04','2025-05'" "'2025-06','2025-07','2025-08'"
        "'2025-09','2025-10','2025-11'" "'2025-12','2026-01','2026-02'" "'2026-03','2026-04','2026-05'" "'2026-06','2026-07','2026-08'")
for rng in "${CHUNKS[@]}"; do
  i=$((i+1))
  sed "s/__COHORTS__/$rng/" sql/cohort_member_rows_all_months.sql > $TMP/chunk.sql
  BODY=$(jq -n --rawfile q $TMP/chunk.sql '{database:2, type:"native", native:{query:$q}}')
  curl -s -X POST https://fomf2.metabaseapp.com/api/dataset -H "x-api-key: $KEY" -H "Content-Type: application/json" -d "$BODY" \
    | jq '{cols:(.data.cols|map(.name)), rows:.data.rows, error:.error}' > $TMP/m$i.json
  jq -r 'if .error then "ERROR chunk '$i': "+.error[0:400] else "chunk '$i': "+(.rows|length|tostring)+" rows" end' $TMP/m$i.json
  jq -e '.error == null and (.rows|length) < 2000' $TMP/m$i.json >/dev/null || { echo "chunk $i failed or hit the 2000-row cap — split it" >&2; exit 1; }
done
jq -s --arg d "$(date +%F)" --arg n "${#CHUNKS[@]}" '{extracted:$d, note:("one row per new B2C member, cohorts 2024-08..2026-08; fetched in "+$n+" chunks (Metabase 2000-row cap)"), cols:.[0].cols, rows:(map(.rows)|add)}' \
  $(for k in $(seq 1 ${#CHUNKS[@]}); do echo $TMP/m$k.json; done) > data/cohort_member_rows_all_months.json
# Compact: see docs/dashboard.md for the column contract. Column indexes refer to the SQL SELECT order (51 = stage, 52 = spec, v21; 53–58 = fee1, fee2, fee3, tix, cvR, cvW in EUR, v23).
jq -c '[.rows[] | [.[0], .[1], .[2], (if .[3]=="first-time" then "f" else "r" end), (if .[4]=="ONE_YEAR" then 1 else 3 end), (.[5]|.[0:10]),
  ((if .[6] then 1 else 0 end) + (if .[7] then 2 else 0 end) + (if .[8] then 4 else 0 end) + (if .[9] then 8 else 0 end) + (if .[10] then 16 else 0 end)
   + (if .[11] then 32 else 0 end) + (if .[12] then 64 else 0 end) + (if .[15] then 128 else 0 end) + (if .[16] then 256 else 0 end) + (if .[17] then 512 else 0 end)
   + (if .[20] then 1024 else 0 end) + (if .[21] then 2048 else 0 end) + (if .[22] then 4096 else 0 end) + (if .[23] then 8192 else 0 end)
   + (if .[24] then 16384 else 0 end) + (if .[25] then 32768 else 0 end) + (if .[32] then 65536 else 0 end)
   + (if .[33] then 131072 else 0 end) + (if .[34] then 262144 else 0 end) + (if .[35] then 524288 else 0 end) + (if .[36] then 1048576 else 0 end) + (if .[37] then 2097152 else 0 end) + (if .[38] then 4194304 else 0 end)),
  ({"Refresher-led":"R","Webinar-led":"W","On-demand accredited-led":"A","SYFAT-led":"S","On-demand-led":"O","Mixed":"M","Unknown":"U"}[.[13]]), .[14], .[18], .[19], .[26], .[27], .[28], .[29], .[30], .[31], .[39], .[40], .[41], .[42], .[43], .[44], .[45], .[46], .[47], .[48], .[49], .[50], .[51], .[52], (.[53]|round), (.[54]|round), (.[55]|round), (.[56]|round), (.[57]|round), (.[58]|round)]]' \
  data/cohort_member_rows_all_months.json > data/members_compact.json
echo "members: $(jq '.rows|length' data/cohort_member_rows_all_months.json)  compact: $(wc -c < data/members_compact.json) bytes"
rm -rf $TMP
