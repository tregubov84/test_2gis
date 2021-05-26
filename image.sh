#!/bin/bash
FILE=$1


function cropImage()
{
        NAME=$(echo $2 | cut -d'.' -f1)
        EXTENSION=$(echo $2 | cut -d'.' -f2)
        if ! test -f $NAME"_thumbnail."$EXTENSION; then
                convert $2 -resize $1 $NAME"_thumbnail."$EXTENSION
        fi
}

if test -f "$FILE"; then
        DIR=$(ls $FILE | awk '{print $1}' | grep '\.jpg$' | awk '!/_thumbnail/')
else
        DIR=$(du -a . | awk '{print $2}' | grep '\.jpg$' | awk '!/_thumbnail/')
fi
for file in $DIR; do
        TEMPNAME=$(basename "$file")
        RESOLUTION=$(convert {$TEMPNAME} -print "%w %h\n" /dev/null)
        W=$(echo $RESOLUTION | awk '{print $1}')
        H=$(echo $RESOLUTION | awk '{print $2}')

        if [ $W -gt $H ]; then
                cropImage "360x" $TEMPNAME
        else
                cropImage "x360" $TEMPNAME
        fi
done
