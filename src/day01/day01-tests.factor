! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: tools.test day01 ;
IN: day01.tests

: example ( -- n-seq ) { 199
  200
  208
  210
  200
  207
  240
  269
  260
  263
} ;

[ 7 ] [ example silver ] unit-test
[ 5 ] [ example gold ] unit-test
