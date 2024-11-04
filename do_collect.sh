#!/bin/bash

# exit on errors
set -e

temp_file="_tmp_uho_cdbpv.epd"

if [ -f "$temp_file" ]; then
    echo "$temp_file already exists. Exiting."
    exit 0
fi

python ../cdblib/cdbbulkpv.py -s -c 8 --stable --user rob uho.epd >"$temp_file"

mv "$temp_file" uho_cdbpv.epd

python ../caissatrack/caissatrack.py uho_cdbpv.epd >>uhotrack.csv
python ../caissatrack/extract_fens.py uho_cdbpv.epd --shortest 1000 --ignore2folds >uho_daily_shortest.epd

git add uhotrack.csv uho_daily_shortest.epd
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log

gzip uho_cdbpv.epd && mv uho_cdbpv.epd.gz ../../google-drive/cdb/
