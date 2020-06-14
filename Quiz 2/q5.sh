#!/bin/bash

set -x

number=20
func()
{
    local number=5
}
func
(( number ++))

echo $number
set +x