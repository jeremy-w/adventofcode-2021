! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hashtables
io io.encodings.utf8 io.files io.styles kernel math math.order
math.parser math.ranges math.statistics math.vectors prettyprint
sequences sets splitting strings tools.continuations vectors
vocabs.metadata ;
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
: neighbors ( hp point -- neighbor-only-hp )
    { { 1 0 } { -1 0 } { 0 1 } { 0 -1 }
      { 1 1 } { -1 -1 } { -1 1 } { 1 -1 } } swap [ v+ ] curry map
    swap extract-keys sift-values ;

! TIL: [ first ] [ second ] bi ===> first2

: square-indexes ( max-over max-down -- indexes )
    [ [0..b] ] bi@
    [ dupd '[ _ 2array ] map ] map nip
    ;

! test case in listener: H{ { { 0 0 } 2 } { { 1 1 } 0 } } HS{ { 1 1 } } purty
:: purty ( hp flashed-points -- )
    hp keys supremum first2 square-indexes
    [ [ dup
        flashed-points in?
           [ hp at H{ { font-style bold } } [ pprint ] with-style ]
           [ hp at pprint ] if
        ] each "\n" write ] each
    ;

:: step ( hp -- hp flashed-points )
    hp [ 1 + ] assoc-map :> hp
    HS{ } :> flashed-points
    [ hp [
        [ flashed-points in? not ] [ 9 > ] bi* and
        ] assoc-filter assoc-empty? not ] [
        ! grab all the 9s not already in flashed-points and store as newly-flashed
        hp [
            [ flashed-points in? not ] [ 9 > ] bi* and
        ] assoc-filter keys :> newly-flashed
        ! incr their neighbors
        newly-flashed [
            hp swap neighbors keys
            [ hp swap [ 1 + ] change-at ] each
        ] each
        ! add the newly-flashed to flashed-points
        flashed-points newly-flashed adjoin-all
    ] while
    ! reset 9 > to 0 in hp before returning
    hp [ dup 9 > [ drop 0 ] when ] assoc-map :> hp
    hp flashed-points
    ;

! how many total flashes after 100 steps?
: silver ( hp -- x*y ) 0 swap 100 [ step '[ _ cardinality + ] dip ] times drop ;

: gold ( hp -- n ) drop f ;

: day11 ( -- silverAnswer goldAnswer ) "day11" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
