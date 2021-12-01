! Copyright (C) 2021 Your name.
! See http://factorcode.org/license.txt for BSD license.
USING: accessors io.encodings.utf8 io.files kernel math
math.parser math.vectors prettyprint sequences vocabs.metadata
vocabs.parser ;
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

! returns the path to input.txt for the vocab.
: input-path ( vocabspec -- path ) "input.txt" vocab-file-path ;

: day01 ( -- ) "day01" input-path number-lines dup silver "silver: " . .  gold "gold: " . . ;
