! Copyright (C) 2021 Jeremy W. Sherman.
! See http://factorcode.org/license.txt for BSD license.
USING: arrays day08 kernel math sequences splitting tools.test ;
IN: day08.tests

{
T{ display
    { patterns {
        HS{ a c e d g F b }
        HS{ c d F b e }
        HS{ g c d F a }
        HS{ F b c a d }
        HS{ d a b }
        HS{ c e F a b d }
        HS{ c d F g e b }
        HS{ e a F b  }
        HS{ c a g e d b }
        HS{ a b }
        }
    }
    { output {
        HS{ c d F e b }
        HS{ F c a d b }
        HS{ c d F e b }
        HS{ c d b a F }
        }
    }
}
} [ example parse first ] unit-test
