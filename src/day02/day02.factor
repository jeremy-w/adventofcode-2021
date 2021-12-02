! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays combinators io.encodings.utf8 io.files kernel math
math.parser math.vectors sequences splitting vocabs.metadata ;
IN: day02

: line>cmd ( line -- cmd ) " " split first2 string>number 2array ;

: parse ( path -- input ) utf8 file-lines [ line>cmd ] map ;

: at-origin ( -- xy ) { 0 0 } ; inline

: xy-delta ( cmd -- xy ) first2 swap {
    { [ dup "forward" = ] [ drop 0 2array ] }
    { [ dup "down" = ] [ drop 0 swap 2array ] }
    { [ dup "up" = ] [ drop -1 * 0 swap 2array ] }
  } cond ;

: interpret ( input -- xy ) [ xy-delta ] map at-origin [ v+ ] reduce ;

: silver ( input -- x*y ) interpret first2 * ;

! takes { 1 2 3 } 5 to { 1+5 2+3*5 3 }.
: aim-forward-by ( loc by -- loc ) dupd [ last ] dip [ swap drop 0 0 3array ] [ * 0 swap 0 3array ] 2bi v+ v+ ;

! loc like { pos depth aim }. cmd-aim like { "dir" n }
: aim-cmd ( loc cmd -- loc' ) first2 swap {
    { [ dup "forward" = ] [ drop aim-forward-by ] } ! affects pos with +n and depth with +n*aim
    { [ dup "down" = ] [ drop [ first3 ] dip + 3array ] } ! affects only aim
    { [ dup "up" = ] [ drop -1 * [ first3 ] dip + 3array ] } ! affects only aim
  } cond ;

! x y z => pos depth aim
: interpret-aim ( input -- xyz ) { 0 0 0 } [ aim-cmd ] reduce ;

: gold ( input -- x*y ) interpret-aim first2 * ;

: day02 ( -- silverAnswer goldAnswer ) "day02" "input.txt" vocab-file-path parse dup silver swap gold ;
