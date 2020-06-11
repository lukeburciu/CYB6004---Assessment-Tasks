#!/bin/bash

filename=$1

while read -r line
do
   if  [ -f "$line" ]; then
        echo "$line  - That file exists"

    elif [ -d "$line" ]; then
        echo "$line - That's a directory"
    
    else
        echo "$line - I don't know what that is"
    fi
done < "$filename" 