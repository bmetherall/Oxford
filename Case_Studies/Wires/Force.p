set term eps enhanced

#load '~/Templates/Viridis.p'

# palette
set palette defined (0 '#1A9850', 1 '#66BD63',2 '#A6D96A',3 '#D9EF8B',4 '#FEE08B',5 '#FDAE61',6 '#F46D43',7 '#D73027')

set yr [-1:0]
set xr [0:1]
set cbr [0:1000]

set rmargin screen 0.75
set lmargin screen 0.22

set grid
set xl 'x'
set yl 'y'
set zl 'z'
set cbl 'Normal Force'

set ztics 0.1
set cbtics 200
set xyplane 0

set out 'Normal-Force-Bad.eps'
	sp 'NormalForceBad.dat' u 1:2:3:4 w l lw 5 palette not
set out

set out 'Normal-Force-Good.eps'
	sp 'NormalForceGood.dat' u 1:2:3:4 w l lw 5 palette not
set out
