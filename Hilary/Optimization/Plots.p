reset

set grid

p 'Sol.dat' w l not lw 1.5, \
	16.91 * (cosh((x-20) / 16.91) - cosh(20 / 16.91)) dt 5 lw 1.5 not
