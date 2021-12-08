! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day08 kernel math sequences splitting tools.test ;
IN: day08.tests

{
T{ display
    { patterns {
        HS{ a c e d g F b }
        HS{ c d F b e }
        HS{ g c d F a }
        HS{ F b c a d }
        HS{ d a b }
        HS{ c e F a b d }
        HS{ c d F g e b }
        HS{ e a F b  }
        HS{ c a g e d b }
        HS{ a b }
        }
    }
    { output {
        HS{ c d F e b }
        HS{ F c a d b }
        HS{ c d F e b }
        HS{ c d b a F }
        }
    }
}
} [ example parse first ] unit-test

{ 2 } [ { "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe" } parse silver ] unit-test
{ 26 } [ larger-example parse silver ] unit-test

{ 5 } [ H{ { d a } { e b } { a c } { F d } { g e } { b F } { c g } } HS{ c d F e b } decode-pattern ] unit-test
{ HS{ a b } } [ example parse first patterns>> one ] unit-test
{ HS{ e a F b  } } [ example parse first patterns>> four ] unit-test
{ HS{ d a b } } [ example parse first patterns>> seven ] unit-test
{ HS{ a c e d g F b } } [ example parse first patterns>> eight ] unit-test
{ HS{ d e a F b c } } [ example parse first patterns>> nine ] unit-test
{ HS{ d a F g c } } [ example parse first patterns>> two ] unit-test
{ d } [ example parse first patterns>> find-canon-a ] unit-test
{ g } [ example parse first patterns>> find-canon-e ] unit-test
{ c } [ example parse first patterns>> find-canon-g ] unit-test
{ b } [ example parse first patterns>> find-canon-f ] unit-test
{ a } [ example parse first patterns>> find-canon-c ] unit-test
{ e } [ example parse first patterns>> find-canon-b ] unit-test
{ F } [ example parse first patterns>> find-canon-d ] unit-test
{ H{ { d a } { e b } { a c } { F d } { g e } { b F } { c g } } } [ example parse first patterns>> infer-map-to-canon-segments ] unit-test
{ 5353 } [ example parse gold ] unit-test
