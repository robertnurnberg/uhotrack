#!/bin/bash

python3 ../cdblib/cdbbulkpv.py -c 32 --stable --user rob uho.epd >uho_cdbpv.epd
python3 ../caissatrack/caissatrack.py uho_cdbpv.epd >>uhotrack.csv
python3 ../caissatrack/extract_fens.py uho_cdbpv.epd --shortest 100 --ignore2folds >uho_daily_shortest.epd

git add uho_cdbpv.epd uhotrack.csv uho_daily_shortest.epd
git diff --staged --quiet || git commit -m "update data"
git push origin main >&push.log
