! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors arrays assocs day15 kernel math sequences sets
splitting tools.test ;
IN: day15.tests

! dst computes the destination corner.
{ { 9 9 } } [ example parse dst ] unit-test

! zero-dist initializes the xy at 0 distance.
{ H{ { { 0 0 } 0 } } } [
    example parse <pathfinding> dup { 0 0 } zero-dist
    dist>> [ infinity = not nip ] assoc-filter
] unit-test

{ f } [
    example parse <pathfinding> dup { 0 0 } zero-dist dijkstra-step
    unvisited>> { 0 0 } swap in?
] unit-test

{ H{
    { { 0 0 } 0 } ! start
    { { 0 1 } 1 }
    { { 1 0 } 1 }
} } [
    example parse <pathfinding> dup { 0 0 } zero-dist dijkstra-step
    dist>> [ infinity = not nip ] assoc-filter
] unit-test

{ 99 } [
    example parse <pathfinding> dup { 0 0 } zero-dist
    dijkstra-step
    unvisited>> cardinality
] unit-test

{ 98 } [
    example parse <pathfinding> dup { 0 0 } zero-dist
    2 [ dijkstra-step ] times
    unvisited>> cardinality
] unit-test

{ 97 } [
    example parse <pathfinding> dup { 0 0 } zero-dist
    3 [ dijkstra-step ] times
    unvisited>> cardinality
] unit-test

{ 40 } [ example parse silver ] unit-test
! This runs way too slowly - ~45 seconds.
! { 503 } [ day15 drop ] unit-test
