! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day05 kernel math sequences splitting tools.test ;
IN: day05.tests

[ f ] [ 0 9 <point> 5 9 <point> <line> diagonal?  ] unit-test
[ t ] [ 0 0 <point> 8 8 <point> <line> diagonal?  ] unit-test

0 9 <point> 1array [ "0,9" string>point ] unit-test
0 9 <point> 5 9 <point> <line> 1array [ "0,9 -> 5,9" string>line ] unit-test
