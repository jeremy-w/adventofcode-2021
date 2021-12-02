! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test day02 ;
IN: day02.tests

: example ( -- str ) "forward 5
down 5
forward 8
up 3
down 8
forward 2
" ;

[ { 5 0 } ] [ { "forward" 5 } xy-delta ] unit-test
[ { 0 8 } ] [ { "down" 8 } xy-delta ] unit-test
[ { 0 -3 } ] [ { "up" 3 } xy-delta ] unit-test
