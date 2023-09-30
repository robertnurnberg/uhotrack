# UHOtrack

Track the evaluations of the positions in Stefan Pohl's
openings books from [sp-cc.de](https://www.sp-cc.de/uho_xxl_project.htm)
on [chessdb.cn](https://chessdb.cn/queryc_en/) (cdb). 
The average depth of these positions is XXX plies,
with the deepest one XXX plies away from the starting position. 
The positions
have 30.5 pieces on average, and none has fewer than 24 pieces on the board.\

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
