#!/bin/bash

grep -r -w 'sed' #searches for lines that have sed in them
grep -r "^m" # searches for lines that start with m (lowercase)
grep -r -oE '[[:digit:]]{3}' # searches for any line with 3 numbers x3
grep -r -P 'echo.*\b \"\w+\s+\w+\s+\w+' #searches for echo and 3 words with spaces +
grep -r -E '[a-zA-Z0-9+/=]{30,}' #searches for any character that has base64 encoding, looking for hashes instead of plaintext passwords. #https://github.com/mattnotmax/cyberchef-recipes