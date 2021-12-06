! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.functions
math.parser math.ranges math.statistics math.vectors prettyprint
sequences sets sorting splitting strings tools.continuations
vectors vocabs.metadata ;
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
: string>line ( string -- line ) " -> " split-subseq unpair [ string>point ] bi@ <line> ;
: line-points-simple ( line -- points ) [ from>> ] [ thru>> ] bi 2dup same-over? [
    dup over>> -rot
    [ down>> ] bi@ [a,b]
    swap [ swap <point> ] curry map
    ] [
    dup down>> -rot
    [ over>> ] bi@ [a,b]
    swap [ <point> ] curry map
    ] if ;
:: line-points-diag ( line -- points )
    line from>> :> AB
    line thru>> :> ab
    AB over>> :> A AB down>> :> B
    ab over>> :> a ab down>> :> b
    a A - abs :> n
    a A - :> dA
    b B - :> dB
    AB 1vector n [ dup last clone [ dA signum + ] change-over [ dB signum + ] change-down suffix! ] times
    ;
: line-points ( line -- points ) dup diagonal? [ line-points-diag ] [ line-points-simple ] if ;
! t if point falls within line.
: crosses-point? ( line point -- ? ) swap line-points in? ;

: input-lines>lines ( lines -- <line>s ) harvest [ string>line ] map ;

! true if more than one line crosses the point.
: overlap? ( lines point -- ? ) [ crosses-point? ] curry [ find drop ] [ find-last drop ] 2bi = not ;

: point-pair ( line -- 2array ) [ from>> ] [ thru>> ] bi 2array ;
: max-over ( lines -- n ) [ point-pair ] map concat [ over>> ] map natural-sort last ;
: max-down ( lines -- n ) [ point-pair ] map concat [ down>> ] map natural-sort last ;
! collection of all points, from 0,0 to N,M.
: all-points ( lines -- seq ) [ max-over [0,b] ] [ max-down [0,b] ] bi
    [ [ <point> ] curry ] map
    [ [ map ] curry ] map
    [ dupd call( over -- point ) ] map
    nip
    concat ;

! : line-points ( line -- points ) 1array all-points ;

: overlapping-points ( <line>s -- n ) [ diagonal? ] reject [ line-points ] map concat histogram [ nip 2 < ] assoc-reject keys ;
: overlapping-points-diag ( <line>s -- n ) [ line-points ] map concat histogram [ nip 2 < ] assoc-reject keys ;

! determine the number of points where at least two lines overlap. ignore diagonal lines.
: silver ( input -- x*y ) input-lines>lines overlapping-points length ;

: gold ( input -- n ) input-lines>lines overlapping-points-diag length ;

: day05 ( -- silverAnswer goldAnswer ) "day05" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
