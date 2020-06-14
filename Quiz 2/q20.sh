#!/bin/bash

awk 'BEGIN { print "Thing" } { print "Stuff" } END { print "Hi" }' input.txt