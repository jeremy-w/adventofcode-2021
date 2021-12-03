! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays assocs combinators io.encodings.utf8 io.files
kernel math math.parser math.ranges math.statistics math.vectors
sequences splitting strings vectors vocabs.metadata ;
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

:: (winnow) ( keeper-bits vec i -- keeper-bits smaller-vec i )
    keeper-bits i swap nth :> keeper-bit
    keeper-bits
    vec [ i swap nth keeper-bit = ] filter
    "after i" . vec .
    i
    ;

: winnow ( keeper-bits vec i -- keeper-bits smaller-vec )
    over length 1 > [
        (winnow)
    ] when drop ;

: oxygen-generator-rating ( matrix -- n )
    dup flip [ histogram ] map [ gamma-bit ] map
    swap >vector
    dup first length [0,b)
    [ winnow ] each
    swap drop
    first as-dec ;

: c02-scrubber-rating ( matrix -- n )
    dup flip [ histogram ] map [ gamma-bit flip-bitchar ] map
    swap >vector
    dup first length [0,b)
    [ winnow ] each
    swap drop
    first as-dec ;

: life-support-rating ( matrix -- n ) [ oxygen-generator-rating ] [ c02-scrubber-rating ] bi * ;

: gold ( input -- n ) [ string>1strings ] map life-support-rating ;

: day03 ( -- silverAnswer goldAnswer ) "day03" "input.txt" vocab-file-path utf8 file-lines [ silver ] [ gold ] bi ;
