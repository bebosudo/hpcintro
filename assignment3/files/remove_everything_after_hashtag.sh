#!/bin/bash

# pass the name of the file from which to remove the characters after the first
# occurence of the '#' as the first parameter of this script.

while read l
do
    echo $l |sed 's/\#.*//'
done < $1
