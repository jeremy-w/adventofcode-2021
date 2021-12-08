! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel math math.functions
math.order math.parser sequences sorting splitting
vocabs.metadata ;
IN: day07

: parse ( line -- ns ) "," split [ string>number ] map natural-sort ;

: example ( -- ns ) "16,1,2,0,4,2,7,1,2,14" "\n" split first parse ;

: median ( ns -- n ) dup length 2 / floor swap nth ;
: linear-distance ( n ns -- d ) [ - abs ] with map sum ;
: silver ( ns -- x*y ) dup [ median ] dip linear-distance ;

: mean ( ns -- x ) [ sum ] [ length ] bi / ;
: arithmetic-distance ( x ns -- d ) [ - abs dup 1 + * 2 / floor ] with map sum ;
! GOTCHA: the mean is not integral, so we need to check above and below.
: gold ( ns -- n ) dup mean [ floor over arithmetic-distance ] [ ceiling pick arithmetic-distance ] bi min nip ;

: day07 ( -- silverAnswer goldAnswer )
    "day07" "input.txt" vocab-file-path
    utf8 file-lines first parse
    [ silver ] [ gold ] bi ;
