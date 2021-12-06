! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day06 kernel math sequences splitting tools.test ;
IN: day06.tests

[ H{ { 1 1 } { 2 1 } { 3 2 } { 4 1 } } ] [ example parse ] unit-test
[ H{ { 0 1 } { 1 1 } { 2 2 } { 3 1 } } ] [ example parse step ] unit-test
[ H{ { 0 1 } { 1 2 } { 2 1 } { 6 1 } { 8 1 } } ] [ example parse step step ] unit-test
[ 26 ] [ example parse 18 simulate count-fish ] unit-test
[ 5934 ] [ example parse 80 simulate count-fish ] unit-test
[ 380612 ] [ day06 drop ] unit-test  ! silver answer

[ 26984457539 ] [ example parse 256 simulate count-fish ] unit-test
[ 1710166656900 ] [ day06 nip ] unit-test  ! gold answer
