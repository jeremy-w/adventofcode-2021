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

! A heightmap is just an assoc { over down } => height.

: parse-row ( string down -- heightmap )
    swap [ 1string string>number ] map
    swap [ 2array swap 2array ] curry map-index
    >hashtable ;
: parse ( lines -- heightmap ) [ parse-row ] map-index assoc-combine ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day09 ( -- silverAnswer goldAnswer ) "day09" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
