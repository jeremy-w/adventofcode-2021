! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day11 kernel math sequences splitting tools.test ;
IN: day11.tests

! adds 1 to value.
{ H{
    { { 0 0 } 1 }
    } } [ H{
    { { 0 0 } 0 }
    } incr-energy-levels ] unit-test
! does not wrap around.
{ H{
    { { 0 0 } 10 }
    } } [ H{
    { { 0 0 } 9 }
    } incr-energy-levels ] unit-test

{  H{
    { { 0 0 } 0 }
} 0 } [ H{
    { { 0 0 } 0 }
} { 0 0 } flash-value ] unit-test
{ H{
    { { 0 0 } F }
} 1 } [ H{
    { { 0 0 } F }
} { 0 0 } flash-value ] unit-test

{
    H{
        { { 0 0 } 3 } { { 1 0 } F }
        { { 0 1 } F } { { 1 1 } F }
    }
} [
    H{
        { { 0 0 } 0 } { { 1 0 } F }
        { { 0 1 } F } { { 1 1 } F }
    } { 0 0 } flash-incr
] unit-test

{ 1656 } [ example parse silver ] unit-test
{ 1608 } [ day11 drop ] unit-test

{ 195 } [ example parse gold ] unit-test
{ 214 } [ day11 nip ] unit-test
