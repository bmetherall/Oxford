set terminal epslatex standalone color size 4.0in,2.67in lw 3 font 'cmss'

set grid
set xl 'Units Sold'
set yl 'Number of Days'
set samples 1000
set yr [0:120]

do for [t=0:20] {
    set output sprintf('./Frame'.t.'.tex')
    p '../../SaleData.dat' u 1:(1.0) smooth frequency w boxes not, \
    '../Fit'.t.'.dat' u 1 smooth csplines w l lc 7 lw 1.5 not
    set out
}

reset

set grid
set xl 'Units Sold'
set yl 'Number of Days'
set samples 1000
set yr [0:60]

do for [t=0:145] {
    set output sprintf('./FakeFrame'.t.'.tex')
    p '../../FakeData.dat' u 1:(1.0/5) smooth frequency w boxes not, \
    '../Fake'.t.'.dat' u (($1)/5.0) smooth csplines w l lc 7 lw 1.5 not
    set out
}

reset
