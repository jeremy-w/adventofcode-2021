! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day03 math sequences splitting tools.test ;
IN: day03.tests

: example ( -- str ) "00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
" "\n" split harvest ;

[ 22 9 ] [ example gamma-epsilon ] unit-test
