! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs hashtables heaps
io.encodings.utf8 io.files kernel math math.parser math.vectors
sequences splitting strings vocabs.metadata ;
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
TUPLE: pathfinding hm prev dist ;
: pathfinding-init-dist ( pathfinding -- pathfinding )
    dup hm>> keys [
        [ infinity swap pick set-at ] curry change-dist
    ] each ;
: <pathfinding> ( hm -- pathfinding )
    H{ } clone
    H{ } clone
    pathfinding boa
    pathfinding-init-dist ;

: start-at ( pathfinding xy -- )
    [ dist>> ] dip 0 swap rot set-at ;
: next-step ( pathfinding -- cost xy )
    dist>> dup values infimum swap dupd value-at ;
: find-path ( hm -- cost )
    <pathfinding>
    dup { 0 0 } start-at
    ! TODO: repeat this till unvisited queue is empty.
    ! TODO: actually create the unvisited queue. :|
    ! dup [ next-step ] [  ]
    drop 0 ;

! pathfinding: find path with lowest total risk, and output the sum of that risk. the nodes visited after the start point incur risk; effectively the vertex label is the label for all inbound paths to that vertex.
: silver ( input -- x*y ) drop f ;

: gold ( input -- n ) drop f ;

: day15 ( -- silverAnswer goldAnswer ) "day15" "input.txt" vocab-file-path utf8 file-lines parse [ clone silver ] [ clone gold ] bi ;
