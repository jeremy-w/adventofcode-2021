! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs day14 io.encodings.utf8 io.files
kernel math math.statistics sequences splitting tools.test
vocabs.metadata ;
IN: day14.tests

{ T{ template { polymer "CHB" } { rules H{ } } } } [ "" H{ } <template> "CHB" parse-line ] unit-test
{ T{ template { polymer "" } { rules H{ { "CH" "CB" } } } } } [ "" H{ } <template> "CH -> B" parse-line ] unit-test

{ "NCNBCHB" } [ example parse step polymer>> ] unit-test

{ 1588 } [ example parse silver ] unit-test
{ 3118 } [ "day14" "input.txt" vocab-file-path utf8 file-lines parse silver ] unit-test

example parse step >counting-template
counts>>
1array
[
    example parse >counting-template step-counts
    counts>>
] unit-test

example parse 10 [ step ] times >counting-template counts>> 1array
[
    example parse >counting-template 10 [ step-counts ] times
    counts>>
] unit-test

example parse 10 [ step ] times polymer>> histogram string-keys 1array
[
    example parse >counting-template 10 [ step-counts ] times
    >char-histogram string-keys
] unit-test

example parse silver 1array
[
    example parse >counting-template 10 [ step-counts ] times
    >char-histogram
    strength
] unit-test

! we are overcounting somehow
{ 2188189693529 } [ example parse gold ] unit-test
