# UHOtrack

Track the evaluations of the positions in Stefan Pohl's
openings books from [sp-cc.de](https://www.sp-cc.de/uho_xxl_project.htm)
on [chessdb.cn](https://chessdb.cn/queryc_en/) (cdb). 
There are 693291 unique positions in total. They all arise as positions
after 8 moves in human games, but on cdb their average depth is 15.9 plies,
with the distribution of their depths in plies given by
`4: 2, 8: 11, 10: 58, 12: 1918, 14: 17621, 16: 673681`.
The positions have 30.5 pieces on average, and none has fewer than 24 pieces 
on the board.

The file book `uho.epd` was created with the command
```shell
cat UHO_MEGA_2022_+110_+149.epd UHO_XXL_2022_+100_+129.epd UHO_XXL_+0.80_+1.09.epd UHO_XXL_2022_+110_+139.epd UHO_XXL_+0.90_+1.19.epd UHO_XXL_2022_+120_+149.epd UHO_XXL_+1.00_+1.29.epd | awk '{print $1, $2, $3, $4}' | sort | uniq | shuf > uho.epd
```
based on the books available from
[official-stockfish/books](https://github.com/official-stockfish/books).
The file [`uho_cdbpv.epd`](uho_cdbpv.epd) 
contains the current cdb evaluations and PVs for each position. It is created 
daily with the help of the script `cdbbulkpv.py` from 
[cdblib](https://github.com/robertnurnberg/cdblib), and the obtained statistics
are written to [`uhotrack.csv`](uhotrack.csv).

---

<p align="center"> <img src="uhotrack.png?raw=true"> </p>

---

<p align="center"> <img src="uhotrackpv.png?raw=true"> </p>

---

## Progress

The following graph attempts to measure the progress cdb makes in exploring
and evaluating the positions in `uho.epd`. See
[caissatrack](https://github.com/robertnurnberg/caissatrack)
for a precise description of the plotted indicators.

<p align="center"> <img src="uhotracktime.png?raw=true"> </p>

---

## Get involved

If you want to help improve the coverage of these positions on cdb, you could
manually or systematically explore them on [chessdb.cn](https://chessdb.cn/queryc_en/). As an example for an automated solution for the latter, you could 
run the script `launch_uho_daily.sh`
```shell
#!/bin/bash

tempdir="/tmp/uhotrack"
gitdir="$HOME/git"
bulkconcurrency=8
depthlimit=20
user="unknown"

for dir in "$tempdir" "$gitdir"; do
    if [ ! -d "$dir" ]; then
        mkdir "$dir"
    fi
done
cd "$gitdir"
for repo in "cdbexplore" "uhotrack"; do
    if [ ! -d "$gitdir/$repo" ]; then
        git clone "https://github.com/robertnurnberg/$repo"
    fi
    cd $repo && git pull >&pull.log
    cd ..
done

python3 "$gitdir"/cdbexplore/cdbbulksearch.py "$gitdir"/uhotrack/uho_daily_shortest.epd --bulkConcurrency $bulkconcurrency --user $user --forever --reload --maxDepthLimit $depthlimit >&"$tempdir"/uho_daily_shortest.log &
```
automatically via `.crontab` entries of the form
```
@reboot sleep 20 && /path_to_script/launch_uho_daily.sh
55 6 * * * cd git/uhotrack && git pull
```
where the second entry is really only needed for server-like machines that run
24/7.
