# UHOtrack

Track the evaluations of the positions in the
[`UHO_4060_v3.epd`](UHO_4060_v3.epd) book from 
[official-stockfish/books](https://github.com/official-stockfish/books)
[chessdb.cn](https://chessdb.cn/queryc_en/) (cdb). 
The average depth of these positions is XXX plies,
with the deepest one XXX plies away from the starting position. 
The positions
have 30.5 pieces on average, and none has fewer than 24 pieces on the board.\
Thanks to Stefan Pohl for his work on the UHO books, see
[sp-cc.de](https://www.sp-cc.de/uho_xxl_project.htm).

The file [`UHO_4060_v3_cdbpv.epd`](UHO_4060_v3_cdbpv.epd) 
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
and evaluating the positions in `UHO_4060_v3_cdbpv.epd`.\
It plots the evolutions in time of the two (daily) indicators
```math
E = \frac{1}{N} \sum_i \left(\min\{\frac{|e_i|}{100},2\} - 1\right)^2
\qquad \text{and} \qquad
D=\sum_i \frac{1}{d_i},
```
where $(e_i, d_i)$ are the evaluation and depth values for the 100K positions,
with the convention that $d_i = \infty$ if the position's PV ends in a terminal
leaf (2-fold repetition, 50 moves rule, stalemate, checkmate or 7men EGTB).
$E$ measures how certain cdb's evaluations are, while $D$ simply sums the
inverses of the lengths of the non-resolved PVs. Note that as cdb (slowly) 
approaches the 32men EGTB, $E$ should converge to 1, while $D$
should converge to 0.\
In addition the graph also shows the evolution of the total number of "on edge"
positions.

<p align="center"> <img src="uhotracktime.png?raw=true"> </p>
