! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs hashtables heaps io
io.encodings.utf8 io.files kernel math math.parser math.vectors
prettyprint sequences sets splitting strings vocabs.metadata ;
IN: day15

: example ( -- lines ) "1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581" "\n" split ;

! day09 comes in handy again. no diagonal motion allowed as there.
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

CONSTANT: infinity 1/0.

! wish there was a worked example of using the path-finding vocab. bet i could learn some things from there.
TUPLE: pathfinding hm prev dist unvisited ;
: pathfinding-init-dist ( pathfinding -- pathfinding )
    dup hm>> keys [
        [ infinity swap pick set-at ] curry change-dist
    ] each ;
: pathfinding-init-unvisited ( pathfinding -- pathfinding )
    dup hm>> keys [
        [ over adjoin ] curry change-unvisited
    ] each ;
: <pathfinding> ( hm -- pathfinding )
    H{ } clone
    H{ } clone
    HS{ } clone
    pathfinding boa
    pathfinding-init-dist
    pathfinding-init-unvisited ;

: zero-dist ( pathfinding xy -- )
    [ dist>> ] dip 0 swap rot set-at ;
: visit ( pathfinding xy -- )
    ! dup "visit: " write .
    [ unvisited>> ] dip swap delete ;
: next-step ( pathfinding -- cost xy )
    dist>> dup values infimum swap dupd value-at ;
: dst ( hm -- xy )
    keys [ [ first ] map supremum ] [ [ second ] map supremum ] bi 2array ;
: min-unvisited ( pathfinding -- cost xy )
    [ dist>> ] [ unvisited>> ] bi
    [ swap drop in? ] curry assoc-filter
    dup values infimum
    swap dupd value-at ;
:: dijkstra-step ( pathfinding -- pathfinding )
    pathfinding min-unvisited :> ( cost u )
    pathfinding u visit
    pathfinding hm>> u neighbors keys
    pathfinding unvisited>> within
    [| v |
        pathfinding hm>> v of :> step-cost
        cost step-cost + :> alt
        pathfinding dist>> v of :> curr
        alt curr < [
            alt v pathfinding dist>> set-at
            u v pathfinding prev>> set-at
        ] when
    ] each
    pathfinding
    ;
: find-path ( hm -- cost )
    <pathfinding>
    dup { 0 0 } zero-dist
    [ dup unvisited>> cardinality 0 > ] [
        dijkstra-step
    ] while
    dup hm>> dst swap dist>> at ;

! pathfinding: find path with lowest total risk, and output the sum of that risk. the nodes visited after the start point incur risk; effectively the vertex label is the label for all inbound paths to that vertex.
: silver ( hm -- x*y ) find-path ;

: gold ( input -- n ) drop f ;

: day15 ( -- silverAnswer goldAnswer ) "day15" "input.txt" vocab-file-path utf8 file-lines parse [ clone silver ] [ clone gold ] bi ;
