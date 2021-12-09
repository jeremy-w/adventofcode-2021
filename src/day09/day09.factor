! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hashtables
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day09

: example ( -- lines ) "2199943210
3987894921
9856789892
8767896789
9899965678" "\n" split ;

! A heightmap is just an assoc { over down } => height, which we call a "height-point" or "hp".
: height ( hp -- height ) second ;

: parse-row ( string down -- heightmap )
    swap [ 1string string>number ] map
    swap [ 2array swap 2array ] curry map-index
    >hashtable ;
: parse ( lines -- heightmap ) harvest [ parse-row ] map-index assoc-combine ;

: neighbor-of? ( maybe-neighbor-point center-point -- ? )
    v- [ abs ] map [ { 0 1 } = ] [ { 1 0 } = ] bi or ;
: neighbors ( heightmap point -- neighbor-heightmap )
    { { 1 0 } { -1 0 } { 0 1 } { 0 -1 } } swap [ v+ ] curry map
    swap extract-keys sift-values ;
: low-point? ( heightmap point height -- unchanged-heightmap ? )
    [ dupd neighbors ] dip
    [ < nip ] curry
    assoc-filter assoc-empty? ;
: low-points ( heightmap -- low-only-heightmap )
    dup [ low-point? ] assoc-filter nip ;

: risk-level ( nheight -- nrisk ) 1 + ;
: silver ( heightmap -- low-point-risk-level-sum ) low-points values [ risk-level ] map sum ;

: gold ( heightmap -- n ) drop f ;

: input-lines ( -- lines ) "day09" "input.txt" vocab-file-path utf8 file-lines ;
: day09 ( -- silverAnswer goldAnswer ) input-lines parse [ silver ] [ gold ] bi ;
