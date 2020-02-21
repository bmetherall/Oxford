# reset
# set grid

# set logscale xy

# set xlabel 'Number of Beams'
# set ylabel 'Error'

# set yrange [:2]

# a = 1 # Initial guesses
# b = -2

# f(x) = b * x + log(a)

# fit [log(3):log(50)] f(x) 'Error.dat' using (log($1)):(log($2)) via a, b

# plot a * x**b t sprintf('$%1.2f (n-1)^{%1.2f}$', a, b) lc 2 dt 5, \
# 	'Error.dat' using 1:2 pt 7 ps 0.5 lc 1 t 'Data'

reset

set grid
set size ratio -1

set xlabel '$x$'
set ylabel '$y$'

set ytics 1

a = 4.228

plot 'Sol11.dat' w l not lw 1.5, \
	a * (cosh((x-5) / a) - cosh(5 / a)) dt 5 lw 1.5 not

# reset

# set terminal epslatex color size 3.15in,2in lw 3

# load '/home/metherall/Templates/BGY.p'

# set grid
# set xyplane 0
# set samples 250
# set isosamples 250

# set xlabel '$x$'
# set ylabel '$y$'
# set zlabel '$z$' offset screen 0.05, 0.01

# set xtics 1
# set ytics -1, 1, 1
# set ztics 400

# set xrange [-1.5:1.5]
# set yrange [-1.5:1.5]

# set pm3d

# unset surface
# set contour surface
# set cntrparam levels incremental 0, 100, 1200

# unset cl
# unset colorbox

# rosen(x, y) = (1 - x)**2 + 100 * (y - x**2)**2

# rosenconst(x, y) = -(x - 1)**2 - y + 1 <= 0 ? (x + y - 2 <= 0 ? rosen(x, y) : 1/0) : 1/0


# set view 50, 320
# set xtics offset 1
# set ytics offset 0

# set output 'Rosen.tex'
# 	sp rosen(x, y) lc 8 lw 0.6 not
# set out

# set view 50, 50
# set xtics offset 0
# set ytics offset 1

# set output 'RosenConst.tex'
# 	sp rosenconst(x, y) lc 8 lw 0.6 not
#set out
