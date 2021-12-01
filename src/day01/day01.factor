! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: io.encodings.utf8 io.files kernel math math.parser
math.vectors prettyprint sequences ;
IN: day01

! count the number of times a depth measurement increases from the previous measurement
: silver ( {n1,n2,...,nN} -- incrCount )
  0 over remove-nth ! {n2,...,nN} {n1,n2,...nN}
  swap v-
  [ 0 > [ 1 ] [ 0 ] if ] map-sum
  ;

! count the times the sum of a 3-element sliding window increased
: gold ( n-seq -- windowedIncrCount )
  0 over remove-nth
  0 over remove-nth
  swap rot
  v+ v+
  silver
  ;

: number-lines ( path -- num-seq ) utf8 file-lines [ string>number ] map ;

! ???: How do I get a path relative to this day01.factor file? This is from the image root, where I launched the process.
: day01 ( -- ) "./work/day01/input.txt" number-lines dup silver "silver: " . .  gold "gold: " . . ;
