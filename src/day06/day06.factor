! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day06

: example ( -- lines ) "3,4,3,1,2" "\n" split first ;

: parse ( string -- ns ) "," split [ string>number ] map histogram ;

: age ( n -- nums ) {
    { 0 [ { 6 8 } ] }
    [ 1 - 1array ]
} case ;

: spawn ( hist -- hist ) dup -1 of [
        dup -1 of 8 pick at+
        dup -1 of 6 pick at+
        -1 over delete-at
    ] when ;

: step ( hist -- hist ) [ [ 1 - ] dip ] assoc-map spawn ;

: count-fish ( hist -- n ) values sum ;

: simulate ( hist days -- ns ) [ step ] times ;

: silver ( input -- x*y ) parse 80 simulate count-fish ;

: gold ( input -- n ) parse 256 simulate count-fish ;

: day06 ( -- silverAnswer goldAnswer ) "day06" "input.txt" vocab-file-path utf8 file-lines first [ silver ] [ gold ] bi ;
