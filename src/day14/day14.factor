! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping
io.encodings.utf8 io.files kernel math math.parser math.ranges
math.statistics math.vectors prettyprint sequences sets
splitting strings tools.continuations vectors vocabs.metadata ;
IN: day14

: example ( -- lines ) "" "\n" split ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day14 ( -- silverAnswer goldAnswer ) "day14" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
