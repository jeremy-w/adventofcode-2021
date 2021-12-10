! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day10

CONSTANT: brackets H{
    "{}"
    "[]"
    "()"
    "<>"
}

CONSTANT: bracket-value H{
    { CHAR: ) 3 }
    { CHAR: ] 57 }
    { CHAR: } 1197 }
    { CHAR: > 25137 }
}

TUPLE: parsing { src initial: "" } { open initial: V{ } } { mismatch initial: f } ;
C: <parsing> parsing
: incomplete? ( parsing -- ? ) open>> empty? ;
: corrupted? ( parsing -- ? ) mismatch>> ;

: example ( -- lines ) "[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]" "\n" split ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day10 ( -- silverAnswer goldAnswer ) "day10" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
