#!/bin/bash
IFS=','
for text in $(cat words.txt); do
    echo -n "$text"
done