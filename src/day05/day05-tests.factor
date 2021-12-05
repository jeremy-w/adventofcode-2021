! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day05 kernel math sequences splitting tools.test ;
IN: day05.tests

[ f ] [ 0 9 <point> 5 9 <point> <line> diagonal?  ] unit-test
[ t ] [ 0 0 <point> 8 8 <point> <line> diagonal?  ] unit-test

0 9 <point> 1array [ "0,9" string>point ] unit-test
0 9 <point> 5 9 <point> <line> 1array [ "0,9 -> 5,9" string>line ] unit-test

0 9 <point> 5 9 <point> <line>
0 9 <point> 2 9 <point> <line>
2array 1array [ { "0,9 -> 5,9"
"0,9 -> 2,9"
"" } input-lines>lines ] unit-test

 0 0 <point> 0 1 <point> 2array 1array
 [ 0 0 <point> 0 1 <point> <line> line-points ] unit-test

 0 1 <point> 0 0 <point> 2array 1array
 [ 0 1 <point> 0 0 <point> <line> line-points ] unit-test

 1 0 <point> 0 0 <point> 2array 1array
 [ 1 0 <point> 0 0 <point> <line> line-points ] unit-test

 0 0 <point> 1 0 <point> 2array 1array
 [ 0 0 <point> 1 0 <point> <line> line-points ] unit-test

 { t } [ 0 0 <point> 1 0 <point> <line>
    0 0 <point> crosses-point? ] unit-test
{ f } [ 1 1 <point> 1 0 <point> <line>
    0 0 <point> crosses-point? ] unit-test

0 0 <point> 0 1 <point> 0 2 <point> 3array 1array
[ 0 0 <point> 0 2 <point> <line> line-points ] unit-test

{ 5 } [ example input-lines>lines overlapping-points length ] unit-test
