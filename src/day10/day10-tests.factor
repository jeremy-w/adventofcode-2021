! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays day10 kernel math sequences splitting
tools.test ;
IN: day10.tests

! incomplete?
{ t } [
    <parsing>
        "(" >>src
        V{ CHAR: ( } >>open
    incomplete?
] unit-test

! open bracket:
<parsing>
    "()" >>src
    V{ CHAR: ( } >>open
1array
[
    <parsing>
        "()" >>src
        CHAR: ( parse-char
] unit-test

! matching close bracket:
<parsing>
    "()" >>src
1array
[
    <parsing>
        "()" >>src
        V{ CHAR: ( } >>open
        CHAR: ) parse-char
] unit-test

! mismatched close bracket:
<parsing>
    "(}" >>src
    V{ CHAR: ( } >>open
    CHAR: } >>mismatch
1array
[
    <parsing>
        "(}" >>src
        V{ CHAR: ( } >>open
        CHAR: } parse-char
] unit-test

! valid chunks:
<parsing>
    "()" >>src
1array
[ "()" parse ] unit-test
<parsing>
    "[]" >>src
1array [ "[]" parse ] unit-test
<parsing>
    "([])" >>src
1array
[ "([])" parse ] unit-test
<parsing>
    "{()()()}" >>src
1array
[ "{()()()}" parse ] unit-test
<parsing>
    "<([{}])>" >>src
1array
[ "<([{}])>" parse ] unit-test
<parsing>
    "[<>({}){}[([])<>]]" >>src
1array
[ "[<>({}){}[([])<>]]" parse ] unit-test
<parsing>
    "(((((((((())))))))))" >>src
1array
[ "(((((((((())))))))))" parse ] unit-test

! incomplete chunks:
<parsing>
    "<([{}])" >>src
    V{ CHAR: < } >>open
1array
[ "<([{}])" parse ] unit-test

! corrupt chunks:
<parsing>
    "<([{>]]]]" >>src
    V{ CHAR: < CHAR: ( CHAR: [ CHAR: { } >>open
    CHAR: > >>mismatch
1array
[ "<([{>]]]]" parse ] unit-test

! silver:
{ 26397 } [ example [ parse ] map silver ] unit-test
{ 345441 } [ day10 drop ] unit-test
