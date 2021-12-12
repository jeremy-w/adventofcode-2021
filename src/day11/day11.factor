! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hash-sets
hashtables io io.encodings.utf8 io.files io.styles kernel math
math.order math.parser math.ranges math.statistics math.vectors
prettyprint sequences sets splitting strings tools.continuations
vectors vocabs.metadata ;
IN: day11

: example ( -- lines ) "5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526" "\n" split ;

! day09 has some useful code here.
: energy ( hp -- energy ) second ;
: parse-row ( string down -- hp )
    swap [ 1string string>number ] map
    swap [ 2array swap 2array ] curry map-index
    >hashtable ;
: parse ( lines -- hp ) harvest [ parse-row ] map-index assoc-combine ;
: neighbor-points ( point -- points )
    { { 1 0 } { -1 0 } { 0 1 } { 0 -1 }
      { 1 1 } { -1 -1 } { -1 1 } { 1 -1 } } swap [ v+ ] curry map ;
: neighbors ( hp point -- neighbor-only-hp )
    neighbor-points
    swap extract-keys sift-values ;

! TIL: [ first ] [ second ] bi ===> first2

: square-indexes ( max-over max-down -- indexes )
    [ [0..b] ] bi@
    [ dupd '[ _ 2array ] map ] map nip
    ;

:: purty ( hp -- )
    hp keys supremum first2 square-indexes
    [ [ hp at dup 0 =
           [ H{ { font-style bold } } [ pprint ] with-style ]
           [ pprint ] if
        ] each "\n" write ] each
    ;

: incr-energy-levels ( hp -- hp )
    [ 1 + ] assoc-map ;

SYMBOL: F

: flash-value ( hp point -- hp n )
    over at F = 1 0 ? ;

! poin must be flashable.
: flash-incr ( hp point -- hp )
    dupd swap over neighbor-points [ flash-value ] map sum
    '[ _ + ] change-at ;

: flashable? ( hp point -- ? )
    of [ f = not ] [ F = not ] [ 0 = not ] tri and and ;

: flash ( nflashed hp -- nflashed hp )
    [ dup 9 > [ drop F [ 1 + ] 2dip ] when ] assoc-map
    F over value? [
        dup [ F = nip ] assoc-filter
        keys [ neighbor-points ] map concat
        >hash-set members
        [ 2dup flashable? [ flash-incr ] [ drop ] if ] each
        [ dup F = [ drop 0 ] when ] assoc-map
        flash
    ] when ;

: step ( hp -- hp nflashed )
    incr-energy-levels 0 swap flash swap ;

! how many total flashes after 100 steps?
: silver ( hp -- x*y ) 0 swap 100 [ step '[ _ + ] dip ] times drop ;

: gold ( hp -- n ) drop f ;

: day11 ( -- silverAnswer goldAnswer ) "day11" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
