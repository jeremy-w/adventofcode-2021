! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays assocs combinators grouping io.encodings.utf8
io.files kernel math math.parser math.ranges math.statistics
math.vectors prettyprint sequences splitting strings vectors
vocabs.metadata ;
IN: day04

TUPLE: board rows marked ;

C: <board> board

TUPLE: game next-number-index numbers boards ;

C: <game> game

: sections ( lines -- line-groups ) { "" } split harvest ;

: section>numbers ( line-group -- numbers ) first { CHAR: , } split [ string>number ] map ;

: row>numbers ( string -- numbers ) " " split harvest [ string>number ] map ;

: section>rows ( line-group -- rows ) [ row>numbers ] map ;

: sections>game ( line-groups -- game ) 0 swap 1 cut [ first section>numbers ] dip [ section>rows HS{ } <board> ] map <game> ;

: parse ( lines -- game ) sections sections>game ;

: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day04 ( -- silverAnswer goldAnswer ) "day04" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
