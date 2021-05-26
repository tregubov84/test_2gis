#!/bin/bash

find . -name "*.jpg"

identify -format '%w %h' "*.jpg"

a=%w
b=%h

if $a<$b
then convert *.jpg -resize x360 $NAME"_thumbnail".jpg  
else convert *.jpg -resize  360 $NAME"_thumbnail".jpg
fi












