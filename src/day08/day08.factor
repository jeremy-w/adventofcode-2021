! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hash-sets
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata
words ;
IN: day08

! The 7 segments.
CONSTANT: a CHAR: a
CONSTANT: b CHAR: b
CONSTANT: c CHAR: c
CONSTANT: d CHAR: d
CONSTANT: e CHAR: e
CONSTANT: F CHAR: f ! capitalize to avoid clobbering f for false
CONSTANT: g CHAR: g

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

: larger-example ( -- lines ) "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
fgae cfgab fg bagce
" "\n" split ;

TUPLE: display patterns output ;
C: <display> display

: parse-pattern ( string -- pattern ) "f" "F" replace [ 1string "day08" lookup-word ] { } map-as >hash-set ;
: parse-patterns ( string -- patterns ) " " split [ parse-pattern ] map ;
: parse-display ( line -- display ) " | " split-subseq [ first ] [ second ] bi [ parse-patterns ] bi@ <display> ;
: parse ( lines -- displays ) [ parse-display ] map ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day08 ( -- silverAnswer goldAnswer ) "day08" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
