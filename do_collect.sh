#!/bin/bash

temp_file="_tmp_uho_cdbpv.epd"

if [ -f "$temp_file" ]; then
    echo "$temp_file already exists. Exiting."
    exit 0
fi

python3 ../cdblib/cdbbulkpv.py -c 24 --stable --user rob uho.epd >"$temp_file"

mv "$temp_file" uho_cdbpv.epd

python3 ../caissatrack/caissatrack.py uho_cdbpv.epd >>uhotrack.csv
python3 ../caissatrack/extract_fens.py uho_cdbpv.epd --shortest 1000 --ignore2folds >uho_daily_shortest.epd

git add uhotrack.csv uho_daily_shortest.epd
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log
