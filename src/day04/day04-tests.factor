! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day04 kernel math sequences splitting tools.test ;
IN: day04.tests

: example ( -- str ) "7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
" "\n" split ;

[ {
    { "1,2,3" }
    { "1" }
    { "1" "1" }
} ] [ { "1,2,3"
""
"1"
""
"1"
"1" } sections ] unit-test

[ { 1 2 34 } ] [ { "1,2,34" } section>numbers ] unit-test

[ { { 1 2 } { 3 4 } } ] [ { " 1  2" " 3  4" } section>rows ] unit-test

[ T{ game f 0 { 1 2 34 } { T{ board f { { 1 2 } { 3 4 } } HS{ } } } } ]
[ { "1,2,34" "" " 1  2" " 3  4" "" } parse ] unit-test

[ T{ board f { } HS{ 99 } } ] [ { } HS{ } <board> 99 mark ] unit-test

[ f ] [
    T{ board f { { 1 2 } { 3 4 } } HS{ 1 4 } }
    { 1 2 } single-row-win? nip ] unit-test
[ t ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } } { 1 2 } single-row-win? nip ] unit-test
[ f ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 4 } } row-win? ] unit-test
[ t ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } } row-win? ] unit-test
[ f ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 4 } } col-win? ] unit-test
[ t ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 3 } } col-win? ] unit-test
[ t ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } } win? ] unit-test ! via row
[ t ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 3 } } win? ] unit-test ! via col

[ t ] [
    T{ game f 2 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } }
        } }
    over?
] unit-test

[ t ] [
    T{ game f 1 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 } }
        } }
    step! over?
] unit-test

[ T{ game f 2 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } }
        } }
] [
    T{ game f 1 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 } }
        } }
    step!
] unit-test

[ t ] [
        T{ game f 3 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 } }
        } } over?
] unit-test

[ 1 ] [ T{ game f 1 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 } }
        } } last-called-number
] unit-test

[ HS{ 1 2 } 0 ] [ HS{ 1 2 } { 1 2 } sum-unmarked-row ] unit-test
[ HS{ 1 } 2 ] [ HS{ 1 } { 1 2 } sum-unmarked-row ] unit-test
[ HS{ } 3 ] [ HS{ } { 1 2 } sum-unmarked-row ] unit-test

[ 7 ] [ T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } } sum-unmarked ] unit-test

! 3 4 + 2 * ==> 14
[ 14 ] [
    T{ game f 2 { 1 2 3 } {
        T{ board f { { 1 2 } { 3 4 } } HS{ 1 2 } }
        } } score
] unit-test
[ 4512 ] [ example parse play score ] unit-test

[ T{ game f 15 { 7 4 9 5 11 17 23 2 0 14 21 24 10 16 13 6 15 25 12 22 18 20 8 19 3 26 1 }
{ T{ board
    { rows
        {
            { 3 15 0 2 22 }
            { 9 18 13 17 5 }
            { 19 8 7 25 23 }
            { 20 11 10 24 4 }
            { 14 21 16 12 6 }
        }
    }
    { marked HS{ 7 4 9 5 11 17 23 2 0 14 21 24 10 16 13 } }
} }
} ] [ example parse play-to-end ] unit-test
[ 1924 ] [ example parse play-to-end score ] unit-test
