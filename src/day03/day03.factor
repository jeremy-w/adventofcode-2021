! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays assocs combinators io.encodings.utf8 io.files
kernel math math.parser math.statistics math.vectors sequences
splitting strings vocabs.metadata ;
IN: day03

: string>1strings ( str -- arr ) [ 1string ] { } map-as ;

: column-stats ( matrix -- histogram-seq ) [ string>1strings ] map flip [ histogram ] map ;

! most common bit in each col
: gamma-bit ( histogram -- 0/1 ) [ "0" of ] [ "1" of ] bi > [ "0" ] [ "1" ] if ;

: gamma-bits ( histogram-seq -- 01-seq ) [ gamma-bit ] map ;

: as-dec ( 01-seq -- n ) "" join bin> ;

: flip-bitchar ( 0/1 -- 1/0 ) "0" = [ "1" ] [ "0" ] if ;

! least common bit in each col - so gamma, flipped
: epsilon-bits ( histogram-seq -- 01-seq ) gamma-bits [ flip-bitchar ] map ;

: gamma-epsilon ( matrix -- gamma epsilon ) column-stats [ gamma-bits as-dec ] [ epsilon-bits as-dec ] bi ;

: silver ( input -- x*y ) gamma-epsilon * ;

: day03 ( -- silverAnswer ) "day03" "input.txt" vocab-file-path utf8 file-lines [ silver ] call ;
