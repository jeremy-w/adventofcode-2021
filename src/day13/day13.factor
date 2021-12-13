! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day13

: example ( -- lines ) "6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5" "\n" split ;

TUPLE: paper dots folds ;
C: <paper> paper

: parse-dot ( line -- pair )
    "," split [ string>number ] map ;

: parse-fold ( line -- pair )
    " " split last
    "=" split
    1 over [ string>number ] change-nth ;

: parse-line ( paper line -- paper )
    dup length 0 > [
        dup first CHAR: f =
            [ parse-fold [ over push ] curry change-folds ]
            [ parse-dot [ over push ] curry change-dots ] if
    ] [ drop ] if ;

: parse ( lines -- paper )
    V{ } clone V{ } clone <paper> [ parse-line ] reduce ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day13 ( -- silverAnswer goldAnswer ) "day13" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
