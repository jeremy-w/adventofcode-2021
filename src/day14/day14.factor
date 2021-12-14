! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hashtables
io.encodings.utf8 io.files kernel math math.functions
math.parser math.ranges math.statistics math.vectors prettyprint
sequences sets splitting strings tools.continuations vectors
vocabs.metadata ;
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

: simplify-rewrite ( ch b -- ch cb )
    dupd [ first 1string ] dip
    "" glue ;

: parse-line ( template line -- template )
    dup "" =
       [ drop ]
       [ " -> " split-subseq [ "" like ] map
       dup length 1 =
            [ first >>polymer ]
            [ first2 simplify-rewrite
                swap '[ _ _ pick set-at ] change-rules
            ] if
        ] if
    ;

: parse ( lines -- template )
    "" H{ } <template> [ parse-line ] reduce ;

: rewrite-clumps ( polymer rules -- polymer )
    dupd [ last 1string swap ] dip
    swap 2 clump [ over at ] map nip
    swap suffix
    "" join ;

: step ( template -- template )
    dup rules>> [ rewrite-clumps ] curry change-polymer ;

: string-keys ( hashmap -- hashmap )
     [ [ 1string ] dip ] assoc-map ;

: strength ( histogram -- n )
    values [ supremum ] [ infimum ] bi - ;
: run ( template times -- delta )
    [ step ] times
    polymer>> histogram string-keys
    strength
    ;
: silver ( template -- x*y ) 10 run ;

TUPLE: counting-template counts last-char rules ;
C: <counting-template> counting-template
: >counting-template ( template -- counting-template )
    [ polymer>> 2 clump histogram ] [ polymer>> last ] [ rules>> ] tri <counting-template> ;
: spawn-pairs ( rules key -- rules keys )
    dup [ over at ] dip
    dupd [ second 1string ] bi@ "" glue
    2array
    ;
: recombine ( alist -- hashtable )
    H{ } clone swap [ swap pick at+ ] assoc-each ;
: step-count ( counts rules -- counts )
    swap >alist [ first2 [ spawn-pairs ] dip [ 2array ] curry map ] map concat nip
    recombine
    ;
: step-counts ( ct -- ct )
    dup rules>> [ step-count ] curry change-counts ;
: counts>char-histogram ( counts -- histogram )
    >alist [
        clone dup clone
           [ 0 over [ first ] change-nth ]
           [ 0 over [ second ] change-nth ]
           bi*
           2array
        ] map concat recombine
        [ 2 / round ] assoc-map ;
: gold ( template -- n )
    >counting-template 40 [ step-counts ] times
    dup counts>> counts>char-histogram
    nip ! 1 rot last-char>> pick at+
    strength
    ;

: day14 ( -- silverAnswer goldAnswer ) "day14" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
