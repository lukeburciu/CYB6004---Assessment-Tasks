#!/bin/bash

#set -x
#set +x

awk '
{
    printf "value: %.2f\n", $2
}' input.txt

#set +x