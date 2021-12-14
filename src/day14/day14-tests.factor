! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays day14 kernel math sequences splitting
tools.test ;
IN: day14.tests

{ T{ template { polymer "CHB" } { rules H{ } } } } [ "" H{ } <template> "CHB" parse-line ] unit-test
{ T{ template { polymer "" } { rules H{ { "CH" "CB" } } } } } [ "" H{ } <template> "CH -> B" parse-line ] unit-test

{ "NCNBCHB" } [ example parse step polymer>> ] unit-test

{ 1588 } [ example parse silver ] unit-test
{ 3118 } [ day14 drop ] unit-test
