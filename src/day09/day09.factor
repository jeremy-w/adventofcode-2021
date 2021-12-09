! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs combinators grouping hashtables
io io.encodings.utf8 io.files kernel math math.order math.parser
math.ranges math.statistics math.vectors prettyprint sequences
sets sorting splitting strings tools.continuations vectors
vocabs.metadata ;
IN: day09

: example ( -- lines ) "2199943210
3987894921
9856789892
8767896789
9899965678" "\n" split ;

! A heightmap is just an assoc { over down } => height, which we call a "height-point" or "hp".
: height ( hp -- height ) second ;

: parse-row ( string down -- heightmap )
    swap [ 1string string>number ] map
    swap [ 2array swap 2array ] curry map-index
    >hashtable ;
: parse ( lines -- heightmap ) harvest [ parse-row ] map-index assoc-combine ;

: neighbor-of? ( maybe-neighbor-point center-point -- ? )
    v- [ abs ] map [ { 0 1 } = ] [ { 1 0 } = ] bi or ;
: neighbors ( heightmap point -- neighbor-heightmap )
    { { 1 0 } { -1 0 } { 0 1 } { 0 -1 } } swap [ v+ ] curry map
    swap extract-keys sift-values ;
: low-point? ( heightmap point height -- unchanged-heightmap ? )
    [ dupd neighbors ] dip
    [ <= nip ] curry
    assoc-filter assoc-empty? ;
: low-points ( heightmap -- low-only-heightmap )
    dup [ low-point? ] assoc-filter nip ;

: risk-level ( nheight -- nrisk ) 1 + ;
: silver ( heightmap -- low-point-risk-level-sum ) low-points values [ risk-level ] map sum ;

! A basin is a flood-fill from a point. It's blocked by 9s. We report a basin as a seq of points.
:: basin ( heightmap low-point -- points )
    low-point 1vector :> points
    low-point 1array :> batch!
    ! XXX: spent forever debugging that i was using |at| rather than |member?| in the assoc-filter quot, because i'd mixed up the type of points.
    ! it would just keep looping, seemingly not even running the body - break never stopped it.
    ! i ultimately manually unrolled it a couple steps to see it going wrong, and stuck a break in the assoc-filter quot once i got wise to the problem.

    ! as an added complication, breakpointing in a word using locals is
    ! basically unreadable; i didn't want to learn to understand the guts of how
    ! locals are implemented, but you need to do that to really understand the
    ! data flow. the locals seemed to be ref'd by number, not name, which makes
    ! it even harder to follow. apparently macros might benefit from the notion
    ! of source-maps.
    [
        ! "batch: " write batch .
        ! "points: " write points .
        batch empty? not
        ! "will continue: " write dup .
    ] [
        heightmap batch [ dupd neighbors ] map nip assoc-combine
        [ 9 < swap points member? not and ] assoc-filter
        keys batch!
        points batch append!
        ! "next batch: " write batch .
        drop
    ] while
    points ;
: basins ( heightmap low-points -- points-seq )
    [ dupd basin ] map nip ;

! Find the three largest basins and multiply their sizes together.
: gold ( heightmap -- n )
    dup low-points keys basins
    [ [ length ] bi@ >=< ] sort
    3 head [ length ] map product ;

: input-lines ( -- lines ) "day09" "input.txt" vocab-file-path utf8 file-lines ;
: day09 ( -- silverAnswer goldAnswer ) input-lines parse [ silver ] [ gold ] bi ;
