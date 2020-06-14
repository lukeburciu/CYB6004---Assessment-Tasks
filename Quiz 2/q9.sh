#!/bin/bash

#set -x
#set +x


#set +x

searchForItems()
{
    grep "items" $1
}

searchForItems shoppingList.txt
#set +x