# UHOtrack

Track the evaluations of the book
[`UHO_Lichess_4852_v1.epd`](https://github.com/official-stockfish/books/raw/master/UHO_Lichess_4852_v1.epd.zip) from
[official-stockfish/books](https://github.com/official-stockfish/books)
on [chessdb.cn](https://chessdb.cn/queryc_en/) (cdb). 
The book contains 2632036 unique positions in total. They all arose as positions
from human games on [Lichess](https://lichess.org) in 2023, 
with an average depth on cdb of 13.2 plies.
The positions have 30.6 pieces on average, and none has fewer than 23 pieces 
on the board.

The file [`uho_cdbpv.epd.gz`](https://drive.google.com/file/d/1yR3AlKSEcrezsSDRPPyD99N9vry_NArD/view?usp=sharing) is created regularly
with the help of the script `cdbbulkpv.py` from 
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
run the script [`launch_uho_daily.sh`](
https://raw.githubusercontent.com/robertnurnberg/uhotrack/main/launch_uho_daily.sh)
automatically via `.crontab` entries of the form
```
@reboot sleep 20 && /path_to_script/launch_uho_daily.sh
55 6 * * * cd git/uhotrack && git pull
```
where the second entry is really only needed for server-like machines that run
24/7.
