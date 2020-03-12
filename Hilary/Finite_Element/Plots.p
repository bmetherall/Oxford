set terminal epslatex color colortext size 4.0in,2.5in lw 3

reset

set grid front
set xrange [-1:1]
set yrange [-1.5:1.25]

set samples 1000

set format x '$%1.1f$'
set format y '$%1.1f$'

set xl '$x$'
set yl rotate by 0 '$y$'

set label 1 '$\Omega$' at 0,0 front center tc lt 1
set label 2 '$\Gamma_0$' at 0.75,0.75 front center tc lt 2
set label 3 '$\Gamma_1$' at -0.75,-0.75 front center tc lt 4
set label 4 '$\Gamma_2$' at 0.75,-0.75 front center tc lt 3

set output 'Domain.tex'
	plot 1-x**2 w filledcurves fs transparent solid 0.2 not, \
		[0:1] -(3.0 / 2 * (1 - x))**(2.0 / 3) lc 1 w filledcurves y=0 fs transparent solid 0.2 not, \
		[-1:0] -(3.0 / 2 * (1 + x))**(2.0 / 3) lc 1 w filledcurves y=0 fs transparent solid 0.2 not, \
		1-x**2 lc 2 lw 1.5 not, \
		[0:1] -(3.0 / 2 * (1 - x))**(2.0 / 3) lc 3 lw 1.5 not, \
		[-1:0] -(3.0 / 2 * (1 + x))**(2.0 / 3) lc 4 lw 1.5 not
set out