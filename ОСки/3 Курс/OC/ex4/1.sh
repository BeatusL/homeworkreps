#! /bin/bash

export A="avtomat"
export B="plz"
TEXT="Dayte $A, $B"
echo $TEXT

TEXT2=${TEXT%,*}
echo $TEXT2

TEXT3="$TEXT2, pozhaluysta"
echo $TEXT3
