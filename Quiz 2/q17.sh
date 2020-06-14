#!/bin/bash

#set -x
#set +x

awk '
{
    print $2
}' input.txt

#set +x