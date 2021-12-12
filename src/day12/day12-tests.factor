! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day12 kernel math sequences splitting tools.test ;
IN: day12.tests

{
    T{ walk
        { map
            H{
                { "A" V{ "c" "b" "end" } }
                { "b" V{ "d" "end" } }
                { "start" V{ "A" "b" } }
            }
        }
        { path
            V{ "start" }
        }
    }
} [ example parse ] unit-test
