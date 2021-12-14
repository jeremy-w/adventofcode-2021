! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day14

: example ( -- lines ) "NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C" "\n" split ;

TUPLE: template polymer rules ;
C: <template> template

: parse-line ( template line -- template )
    dup "" =
       [ drop ]
       [ " -> " split-subseq dup length 1 =
            [ first >>polymer ]
            [ first2 [ members ] bi@
                dupd [ first 1string ] dip
                "" glue
                swap '[ _ _ pick set-at ] change-rules
            ] if
        ] if
    ;

: parse ( lines -- template )
    "" H{ } <template> [ parse-line ] reduce ;

: silver ( template -- x*y ) drop f ;

: gold ( template -- n ) drop f ;

: day14 ( -- silverAnswer goldAnswer ) "day14" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
