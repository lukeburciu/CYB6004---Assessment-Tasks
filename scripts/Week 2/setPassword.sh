#!/bin/bash

#password: secret

read -p "Hi $USER, Please type a folder name: " folder  #Prompts user for name of file to be created

# creates the directory based off the foldername specified
mkdir -p $folder 

# prompts the users for the secret password to be created -s flag to hide input
read -s -p "Hi $USER, Please type a secret password: " pass 

# $pass is hased sha256, limited to the first 64 characters to remove '-' and written to secret.txt
echo $pass | sha256sum > ./$folder/secret.txt

printf "\n\nPassword written to ./$folder/secret.txt \n\n"

exit 22
