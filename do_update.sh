#!/bin/bash

python3 ../caissatrack/plotdata.py uhotrack.csv --cutOff 200 --negplot -ll --edgeMin 90 --edgeMax 105 --PvLengthPlot pvlength.png

git add uhotrack.png uhotrackpv.png uhotracktime.png
git diff --staged --quiet || git commit -m "update plots"
git push origin main >&push.log
