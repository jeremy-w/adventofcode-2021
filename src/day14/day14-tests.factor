! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays day14 io.encodings.utf8 io.files kernel
math sequences splitting tools.test vocabs.metadata ;
IN: day14.tests

{ T{ template { polymer "CHB" } { rules H{ } } } } [ "" H{ } <template> "CHB" parse-line ] unit-test
{ T{ template { polymer "" } { rules H{ { "CH" "CB" } } } } } [ "" H{ } <template> "CH -> B" parse-line ] unit-test

{ "NCNBCHB" } [ example parse step polymer>> ] unit-test

{ 1588 } [ example parse silver ] unit-test
{ 3118 } [ "day14" "input.txt" vocab-file-path utf8 file-lines parse silver ] unit-test

! These two steps should give the same results, and yet.
example parse step >counting-template 1array
[ example parse >counting-template step-counts ] unit-test
