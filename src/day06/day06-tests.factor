! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day06 kernel math sequences splitting tools.test ;
IN: day06.tests

[ { 3 4 3 1 2 } ] [ example parse ] unit-test
[ { 2 3 2 0 1 } ] [ example parse step ] unit-test
[ 26 ] [ example parse 18 simulate length ] unit-test
[ 5934 ] [ example parse 80 simulate length ] unit-test
[ 380612 ] [ day06 drop ] unit-test  ! silver answer
