! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day02 math tools.test ;
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

[ { 6 17 3 } ] [ { 1 2 3 } 5 aim-forward-by ] unit-test

[ { 0 0 5 } ] [ { 0 0 0 } { "down" 5 } aim-cmd ] unit-test
[ { 0 0 -3 } ] [ { 0 0 0 } { "up" 3 } aim-cmd ] unit-test
[ { 1 0 0 } ] [ { 0 0 0 } { "forward" 1 } aim-cmd ] unit-test
[ { 1 10 10 } ] [ { 0 0 10 } { "forward" 1 } aim-cmd ] unit-test
