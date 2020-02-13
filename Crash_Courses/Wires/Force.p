set term eps enhanced

load 'Templates/BGY.p'

set yr [-1:0]
set xr [0:1]
set cbr [0:800]

set rmargin screen 0.75
set lmargin screen 0.22

set grid
set xl 'x'
set yl 'y'
set zl 'z'
set cbl 'Normal Force'

set ztics 0.1
set xyplane 0

set out 'Normal-Force-Bad.eps'
	sp 'NormalForceBad.dat' u 1:2:3:4 w l lw 5 palette not
set out

set out 'Normal-Force-Good.eps'
	sp 'NormalForceGood.dat' u 1:2:3:4 w l lw 5 palette not
set out
