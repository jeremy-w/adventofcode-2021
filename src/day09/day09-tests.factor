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
