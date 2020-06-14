#!/bin/bash

#set -x
#set +x

./q18_1.sh | sed -e '
s/test$/toast/
s/and //g
'

#set +x
