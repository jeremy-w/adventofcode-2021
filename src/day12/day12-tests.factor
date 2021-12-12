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

{
    {
    V{ "start" "A" "a" "A" "a" "end" }
    V{ "start" "A" "a" "b" "a" "end" }
    V{ "start" "A" "a" "end" }
}
} [ "start-A
A-a
a-b
a-end" "\n" split parse distinct-long-paths ] unit-test
{ 36 } [ example parse gold ] unit-test
{ 117509 } [ day12 nip ] unit-test
