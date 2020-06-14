#!/bin/bash

set -x

greet_name()
{
    echo "Hello $1"
}
greet_jessie()
{
    echo "Hellow Jessie"
}
echo "Hello everyone"
greet_jessie
read -p "please type your name"
greet_name "$REPLY"
echo "Goodbye!"

set +x

exit 0