! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day05

! each line represents a line from [(over,down), (over,down)] inclusive at both ends.
: example ( -- lines ) "0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
" "\n" split ;

: unpair ( 2array -- first second ) [ first ] [ second ] bi ;

TUPLE: point over down ;
C: <point> point
: string>point ( string -- point ) "," split [ string>number ] map unpair <point> ;
: same-over? ( p1 p2 -- ? ) [ over>> ] bi@ = ;
: same-down? ( p1 p2 -- ? ) [ down>> ] bi@ = ;

TUPLE: line from thru ;
C: <line> line
: diagonal? ( line -- ? ) [ from>> ] [ thru>> ] bi [ same-over? ] [ same-down? ] 2bi or not ;
: string>line ( string -- line ) " " split >vector 1 swap remove-nth! unpair [ string>point ] bi@ <line> ;

! determine the number of points where at least two lines overlap. ignore diagonal lines.
: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day05 ( -- silverAnswer goldAnswer ) "day05" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
