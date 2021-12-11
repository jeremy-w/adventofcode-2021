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

! test case in listener: H{ { { 0 0 } 2 } { { 1 1 } 0 } } { { 1 1 } } purty
:: purty ( hp flashed-points -- )
    hp keys supremum first2 square-indexes
    [ [ dup
        flashed-points member?
           [ hp at H{ { font-style bold } } [ pprint ] with-style ]
           [ hp at pprint ] if
        ] each "\n" write ] each
    ;

: step ( hp -- hp flashed-points )
    0 ;

! how many total flashes after 100 steps?
: silver ( hp -- x*y ) 0 swap 100 [ step '[ _ + ] dip ] times drop ;

: gold ( hp -- n ) drop f ;

: day11 ( -- silverAnswer goldAnswer ) "day11" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
