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

: day02 ( -- silverAnswer ) "day02" "input.txt" vocab-file-path parse silver ;
