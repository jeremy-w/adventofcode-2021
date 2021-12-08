! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hash-sets
io.encodings.utf8 io.files kernel math math.functions
math.parser math.ranges math.statistics math.vectors prettyprint
sequences sets splitting strings tools.continuations vectors
vocabs.metadata words ;
IN: day08

! The 7 segments.
SYMBOL: a
SYMBOL: b
SYMBOL: c
SYMBOL: d
SYMBOL: e
SYMBOL: F ! capitalize to avoid clobbering f for false
SYMBOL: g

! The canonical mapping from digits to segments.
CONSTANT: canonical-segments H{
    { 0 HS{ a b c e F g } }
    { 1 HS{ c F } }
    { 2 HS{ a c d e g } }
    { 3 HS{ a c d F g } }
    { 4 HS{ b c d F } }
    { 5 HS{ a b d F g } }
    { 6 HS{ a b d e F g } }
    { 7 HS{ a c F } }
    { 8 HS{ a b c d e F g } }
    { 9 HS{ a b c d F g } }
}
! Some stats of number-of-segments => digits with that number:
! H{ { 2 1 } { 3 1 } { 4 1 } { 5 3 } { 6 3 } { 7 1 } }
! This is how we get the easy ones - unique patterns - and hard ones - the 3 each with 5 and 6 segments lit up.

: example ( -- lines ) "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf" "\n" split ;

: larger-example ( -- lines ) "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
" "\n" split ;

TUPLE: display patterns output ;
C: <display> display

: parse-pattern ( string -- pattern ) "f" "F" replace [ 1string "day08" lookup-word ] { } map-as >hash-set ;
: parse-patterns ( string -- patterns ) " " split [ parse-pattern ] map ;
: parse-display ( line -- display ) " | " split-subseq [ first ] [ second ] bi [ parse-patterns ] bi@ <display> ;
: parse ( lines -- displays ) harvest [ parse-display ] map ;

! In the output values, how many times do digits 1, 4, 7, or 8 appear?
! These are the outputs of cardinality 2, 3, 4, and 7, AKA those that aren't 5 or 6.
CONSTANT: easy-cardinalities { 2 3 4 7 }
: easy? ( n -- ? ) easy-cardinalities member? ;
: easy-output-count ( display -- n ) output>> [ cardinality easy? ] filter length ;
: silver ( displays -- n ) [ easy-output-count ] map sum ;

: canon-pattern ( map-to-canon pattern -- canon-pattern ) members [ dupd of ] map nip >hash-set ;
: decode-pattern ( map-to-canon pattern -- n ) canon-pattern canonical-segments value-at ;
: one ( patterns -- pattern ) [ cardinality 2 = ] find nip ;
: four ( patterns -- pattern ) [ cardinality 4 = ] find nip ;
: seven ( patterns -- pattern ) [ cardinality 3 = ] find nip ;
: eight ( patterns -- pattern ) [ cardinality 7 = ] find nip ;
:: nine ( patterns -- pattern )
    patterns [ four ] [ seven ] bi union :> all-but-eg
    patterns [ cardinality 6 = ] filter :> six-segments
    six-segments [ all-but-eg diff cardinality 1 = ] find nip ;
: sole-segment ( pattern -- segment ) members first ;
: find-canon-e ( patterns -- pattern ) [ eight ] [ nine ] bi diff sole-segment ;
: find-canon-a ( patterns -- segment ) [ seven ] [ one ] bi diff sole-segment ;
: find-canon-g ( patterns -- segment ) { [ eight ] [ find-canon-e 1array >hash-set ] [ seven ] [ four ] } cleave union union diff sole-segment ;
: two ( patterns -- pattern ) [ [ cardinality 5 = ] filter ] [ find-canon-e ] bi [ swap in? ] curry find nip ;
: find-canon-f ( patterns -- segment ) [ one ] [ nine ] [ two ] tri diff intersect sole-segment ;
: infer-map-to-canon-segments ( patterns -- assoc ) drop H{ } ;
: output>number ( canon-output -- n ) reverse [ 10 swap ^ * ] map-index sum ;
: decode-output-number ( display -- n ) dup patterns>> infer-map-to-canon-segments [ decode-pattern ] with [ output>> ] dip map output>number ;
! For each entry, determine all of the wire/segment connections and decode the four-digit output values. What do you get if you add up all of the output values?
: gold ( displays -- n ) [ decode-output-number ] map sum ;

: day08 ( -- silverAnswer goldAnswer ) "day08" "input.txt" vocab-file-path utf8 file-lines parse [ silver ] [ gold ] bi ;
