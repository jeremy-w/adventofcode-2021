! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day07 kernel math sequences splitting tools.test ;
IN: day07.tests

{ 37 } [ example silver ] unit-test

{ 168 } [ example gold ] unit-test

{ 335330 } [ day07 drop ] unit-test ! silver
{ 92439766 } [ day07 nip ] unit-test ! gold
