! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day13 kernel math sequences splitting tools.test ;
IN: day13.tests

{ { 6 10 } } [ "6,10" parse-dot ] unit-test
{ { "y" 7 } } [ "fold along y=7" parse-fold ] unit-test

{ 17 } [ example parse silver ] unit-test
{ 618 } [ day13 drop ] unit-test

! ALREKFKU
{
".##..#....###..####.#..#.####.#..#.#..#
#..#.#....#..#.#....#.#..#....#.#..#..#
#..#.#....#..#.###..##...###..##...#..#
####.#....###..#....#.#..#....#.#..#..#
#..#.#....#.#..#....#.#..#....#.#..#..#
#..#.####.#..#.####.#..#.#....#..#..##."
} [ day13 nip ] unit-test
