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

! valid chunks:
! { X } [ "()" parse ] unit-test
! { X } [ "[]" parse ] unit-test
! { X } [ "([])" parse ] unit-test
! { X } [ "{()()()}" parse ] unit-test
! { X } [ "<([{}])>" parse ] unit-test
! { X } [ "[<>({}){}[([])<>]]" parse ] unit-test
! { X } [ "(((((((((())))))))))" parse ] unit-test
