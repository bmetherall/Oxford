set terminal epslatex color size 3.15in,2in lw 3

# Rosenbrock
reset

load '/home/metherall/Templates/BGY.p'

set grid
set xyplane 0
set samples 250
set isosamples 250

set xlabel '$x$'
set ylabel '$y$'
set zlabel '$z$' offset screen 0.05, 0.01

set xtics 1
set ytics -1, 1, 1
set ztics 400

set xrange [-1.5:1.5]
set yrange [-1.5:1.5]

set pm3d

unset surface
set contour surface
set cntrparam levels incremental 0, 100, 1200

unset cl
unset colorbox

rosen(x, y) = (1 - x)**2 + 100 * (y - x**2)**2

rosenconst(x, y) = -(x - 1)**2 - y + 1 <= 0 ? (x + y - 2 <= 0 ? rosen(x, y) : 1/0) : 1/0


set view 50, 320
set xtics offset 1
set ytics offset 0

set output 'Rosen.tex'
	set multiplot
	set size 1.15,1.6
	set origin 0,-0.2
	sp rosen(x, y) lc 8 lw 0.6 not
	unset multiplot
set out

unset size
unset origin

set view 50, 50
set xtics offset 0
set ytics offset 1

set output 'RosenConst.tex'
	set multiplot
	set size 1.15,1.6
	set origin 0,-0.2
	sp rosenconst(x, y) lc 8 lw 0.6 not
	unset multiplot
set out

# Convergence
reset
set grid

set logscale xy
set format xy '$10^{%T}$'

set key bottom left
set key width -3.5

set xlabel '$n$'
set ylabel 'Error'

a = 2 # Initial guesses
b = -2

f(x) = b * x + log(a)

fit [log(1):log(60)] f(x) 'Error.dat' using (log($1)):(log($2)) via a, b

set output 'Convergence.tex'
	plot a * x**b not lc 2 dt 5, \
		'Error.dat' using 1:2 pt 7 ps 0.5 lc 1 t 'Data', \
		1/0 lc 2 dt 5 t sprintf('$%1.2f n^{%1.2f}$', a, b)
set out

set terminal epslatex color size 5in,2.25in lw 3
# Solution
reset

set grid
set size ratio -1

set xlabel '$x$'
set ylabel '$y$' rotate by 0

set key top center


set ytics 1

a = 4.228

set output 'Beam11.tex'
	plot 'Sol11.dat' w l t 'Ten Beams', \
		a * (cosh((x-5) / a) - cosh(5 / a)) dt 5 t 'Continuous'
set out

set output 'Beam5.tex'
	plot 'Sol5.dat' w l t 'Four Beams', \
		a * (cosh((x-5) / a) - cosh(5 / a)) dt 5 t 'Continuous'
set out