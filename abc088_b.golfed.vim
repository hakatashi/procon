dd:s/ /\r/g
:sor! n
:%s/\n/\="-+"[@a+setreg('a',!@a)]/g
C<C-R>=<C-R>"0
<Esc>ZZ