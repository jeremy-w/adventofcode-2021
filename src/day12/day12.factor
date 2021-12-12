! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hash-sets
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations unicode vectors
vocabs.metadata ;
IN: day12

: example ( -- lines ) "start-A
start-b
A-c
A-b
b-d
A-end
b-end" "\n" split ;

TUPLE: walk { map initial: H{ } } { path initial: V{ } } ;
: <walk> ( -- walk )
    walk new
        [ clone ] change-map
        [ clone ] change-path ;

: add-route ( walk from to -- walk )
    swap '[ _ _ pick push-at ] change-map ;

: travel ( walk to -- walk )
    '[ _ over push ] change-path ;

: big-cave? ( cave -- ? )
    upper? ;

M: walk clone
    walk new swap
    dup map>> '[ _ >>map ] dip
    dup path>> clone '[ _ >>path ] dip
    drop ;

: parse-line ( walk line -- walk )
    "-" split first2 add-route ;
: parse ( lines -- walk )
    <walk> [ parse-line ] reduce ;

: explore ( walk from -- walks )
    dup "end" = [ 2drop { } ] [
        over map>> at >hash-set
        over path>> [ big-cave? ] reject >hash-set
        diff members
        [ [ dup clone ] [ travel ] bi* ] map
        nip
    ] if
    ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day12 ( -- silverAnswer goldAnswer ) "day12" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
