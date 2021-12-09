! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day09 kernel math sequences splitting tools.test ;
IN: day09.tests

{ H{ { { 0 0 } 1 } } } [ { "1" } parse ] unit-test
{ H{ { { 0 0 } 8 } { { 1 0 } 9 } } } [ { "89" } parse ] unit-test
{ H{
    { { 0 0 } 8 } { { 1 0 } 9 }
    { { 0 1 } 7 } { { 1 1 } 6 }
    }
} [ { "89" "76" } parse ] unit-test

{ t } [ { 0 0 } { 0 1 } neighbor-of? ] unit-test
{ f } [ { 1 0 } { 0 1 } neighbor-of? ] unit-test
! seeing unexpected filtering of the base heightmap, so testing the input assoc is unchanged in this test:
{ H{
    { { 0 0 } 8 } { { 1 0 } 9 }
    { { 0 1 } 7 } { { 1 1 } 6 }
    }
    H{
    { { 1 0 } 9 }
    { { 0 1 } 7 }
    }
} [ H{
    { { 0 0 } 8 } { { 1 0 } 9 }
    { { 0 1 } 7 } { { 1 1 } 6 }
    } dup { 0 0 } neighbors ] unit-test
{ t } [ H{
    { { 0 0 } 8 } { { 1 0 } 9 }
    { { 0 1 } 7 } { { 1 1 } 6 }
    } { 1 1 } 6 low-point? nip ] unit-test
! low-point has been observed mutating the heightmap, so testing it's unchanged here:
! issue proved to be that i was duping after filtering to neighbors, whoops.
{ H{
    { { 0 0 } 2 } { { 1 0 } 1 }
    { { 0 1 } 3 } { { 1 1 } 9 }
    } f }
[ H{
    { { 0 0 } 2 } { { 1 0 } 1 }
    { { 0 1 } 3 } { { 1 1 } 9 }
    } { 1 1 } 9 low-point? ] unit-test

{ 15 } [ example parse silver ] unit-test
