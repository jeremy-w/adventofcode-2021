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
! GOTCHA: split is by single element, not subsequence, so no "split by string" like " -> " as I originally tried.
: string>line ( string -- line ) " " split >vector 1 swap remove-nth! unpair [ string>point ] bi@ <line> ;
! XXX: This ignores diagonals for now.
: line-points ( line -- points ) [ from>> ] [ thru>> ] bi 2dup same-over? [
    dup over>> -rot
    [ down>> ] bi@ [a,b]
    swap [ swap <point> ] curry map
    ] [
    dup down>> -rot
    [ over>> ] bi@ [a,b]
    swap [ <point> ] curry map
    ] if ;
! TODO: t if point falls within line.
: in? ( line point -- ? ) [ line-points ] dip in? ;

: input-lines>lines ( lines -- <line>s ) harvest [ string>line ] map ;

! true if more than one line crosses the point.
: overlap? ( lines point -- ? ) [ in? ] curry [ find drop ] [ find-last drop ] 2bi = not ;

! TODO: collection of all points, from 0,0 to N,M.
: all-points ( lines -- seq ) drop { } ;

: overlapping-points ( <line>s -- n ) [ diagonal? ] reject dup all-points [ dupd overlap? ] filter nip ;

! determine the number of points where at least two lines overlap. ignore diagonal lines.
: silver ( input -- x*y ) input-lines>lines overlapping-points length ;

: gold ( input -- n ) drop f ;

: day05 ( -- silverAnswer goldAnswer ) "day05" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
