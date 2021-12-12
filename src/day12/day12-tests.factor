! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day12 kernel math sequences splitting tools.test ;
IN: day12.tests

{
    T{ walk
        { map
            H{
                { "A" V{ "start" "c" "b" "end" } }
                { "b" V{ "start" "A" "d" "end" } }
                { "c" V{ "A" } }
                { "d" V{ "b" } }
                { "end" V{ "A" "b" } }
                { "start" V{ "A" "b" } }
            }
        }
    }
} [ example parse ] unit-test

{ 4573 } [ day12 drop ] unit-test
