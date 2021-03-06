##plot "velocity+current.txt" u 9:12 title "+current up-down"
##plot "velocity-current.txt" u 9:15 title "-current down-up"
set xrange [-800:800]
set yrange [-150:150]
set xtics 300
set mxtics
set ytics 50
set mytics
set xlabel "Field [Oe]"
set ylabel "Velocity [m/s]"
set xlabel font "Times, 25"
set ylabel font "TImes, 25"
## font size 10 is the default
set lmargin 12
set bmargin 4
set xlabel offset 0, -0.5
set ylabel offset -3, 0
set tics font "Times, 25"
#set key center top
unset key
set grid

# correction factor from pulse width. But in this linear fitting, this factor does not have any effects on the x-intercepts.
f = 1.1

#slope for positive up-down area
Apu=0.0

Apd=0.0
Anu=0.0
And=0.0

#intercept
Bpu=0.0
Bpd=0.0
Bnu=0.0
Bnd=0.0


vpu(x)=Apu*x+Bpu
vpd(x)=Apd*x+Bpd
vnu(x)=Anu*x+Bnu
vnd(x)=And*x+Bnd

# perform fitting
fit [-450:600] [1:*] vpu(x) "< tail -n +2 velocity+current.txt" u 5:($12 * f) via Apu, Bpu
fit [-600:450] [1:*] vpd(x) "< tail -n +2 velocity+current.txt" u 5:($15 * f) via Apd, Bpd
fit [-600:600] [*:-1] vnu(x) "< tail -n +2 velocity-current.txt" u 5:($12 * f) via Anu, Bnu
fit [-600:350] [*:-1] vnd(x) "< tail -n +2 velocity-current.txt" u 5:($15 * f) via And, Bnd

# to get summary of fitting
fit [-450:600] [1:*] vpu(x) "< tail -n +2 velocity+current.txt" u 5:($12 * f) via Apu, Bpu
fit [-600:450] [1:*] vpd(x) "< tail -n +2 velocity+current.txt" u 5:($15 * f) via Apd, Bpd
fit [-600:600] [*:-1] vnu(x) "< tail -n +2 velocity-current.txt" u 5:($12 * f) via Anu, Bnu
fit [-600:350] [*:-1] vnd(x) "< tail -n +2 velocity-current.txt" u 5:($15 * f) via And, Bnd

plot "velocity+current.txt" u 5:($12 * f) title "+ up-down" lc rgb "red" pt 7 ps 3
rep "velocity+current.txt" u 5:($15 * f) title "+ down-up" lc rgb "red" pt 6 ps 3
rep "velocity-current.txt" u 5:($12 * f) title "- up-down" lc rgb "blue" pt 5 ps 3
rep "velocity-current.txt" u 5:($15 * f) title "- down-up" lc rgb "blue" pt 4 ps 3
rep vpu(x) title "" lc rgb "red" lt 1 lw 1.5
rep vpd(x) title "" lc rgb "red" lt 1 lw 1.5
rep vnu(x) title "" lc rgb "blue" lt 1 lw 1.5
rep vnd(x) title "" lc rgb "blue" lt 1 lw 1.5

