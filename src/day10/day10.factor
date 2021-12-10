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
: <parsing> ( -- parsing ) parsing new [ clone ] change-open ;
: incomplete? ( parsing -- ? ) open>> empty? not ;
: corrupted? ( parsing -- ? ) mismatch>> ;
ERROR: unexpected-char char ;
: parse-open-action ( parsing char -- parsing ) over open>> push ;
: parse-close-action ( parsing char -- parsing )
    dup brackets value-at pick open>> last =
    [ drop dup open>> pop* ]
    [ >>mismatch ]
    if ;
: parse-char ( parsing char -- parsing )
    {
        { [ over corrupted? ] [ drop ] }
        { [ dup brackets key? ] [ parse-open-action ] }
        { [ dup brackets value? ] [ parse-close-action ] }
        [ unexpected-char ]
    } cond ;
: parse ( string -- parsing )
    <parsing>
        over >>src
    [ parse-char ] reduce ;

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

: score-corrupt ( corrupt-parsing -- n )
    mismatch>> bracket-value at ;

: silver ( parsings -- x*y )
    [ corrupted? ] filter
    [ score-corrupt ] map
    sum ;

: completion ( incomplete-parsing -- string )
    open>> clone reverse [ brackets at ] "" map-as ;
CONSTANT: completion-bracket-value H{
    { CHAR: ) 1 }
    { CHAR: ] 2 }
    { CHAR: } 3 }
    { CHAR: > 4 }
}
: score-completion ( string -- n )
    0 [ [ 5 * ] dip completion-bracket-value at + ] reduce ;
: gold ( parsings -- n )
    [ corrupted? ] reject
    [ completion score-completion ] map
    median ;

: day10 ( -- silverAnswer goldAnswer )
    "day10" "input.txt" vocab-file-path
    utf8 file-lines
    [ parse ] map
    [ silver ] [ gold ] bi ;
