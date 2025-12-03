#!/bin/bash

# exit on errors
set -e

PREFIX="uho"
SOURCE="${PREFIX}.epd"
DEST="${PREFIX}_cdbpv.epd"
TEMP_FILE="_tmp_$DEST"
LITRACK_FILE="../litrack/litrack.lock"
TRIMMED="${PREFIX}_trimmed.epd"
ORACLE="../caissatrack/caissa_sorted_100000_cdbpv.epd ../ecotrack/eco_cdbpv.epd ../chopstrack/chops_cdbpv.epd"
FILTER="python ../cdblib/addons/fens_filter_overlap.py --saveMemory --noStats"
CDBBULK="python ../cdblib/cdbbulkpv.py -s -c 8 --stable --user rob"
SCORE="python ../cdblib/addons/score_fens_locally.py"

if [ -f "$TEMP_FILE" ]; then
  echo "$TEMP_FILE already exists. Exiting."
  exit 0
fi

if [ -f "$LITRACK_FILE" ]; then
  echo "$LITRACK_FILE exists. Exiting."
  exit 0
fi

$FILTER $SOURCE $ORACLE >"$TRIMMED"
$CDBBULK "$TRIMMED" >"$TEMP_FILE"
$SCORE $SOURCE $TEMP_FILE $ORACLE >"$DEST"
rm "$TEMP_FILE"

CSV="${PREFIX}track.csv"
SHORTEST="${PREFIX}_daily_shortest.epd"

python ../caissatrack/caissatrack.py "$DEST" >>"$CSV"
python ../caissatrack/extract_fens.py "$DEST" --shortest 1000 --ignore2folds >"$SHORTEST"

git add "$CSV" "$SHORTEST"
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log

gzip -f "$DEST" && cp "${DEST}.gz" ../../google-drive/cdb/
