#!/bin/bash

#password: SecretPassword


echo -n "Hi $USER, please enter secret password: " #Posts message asking for password
read -s  password  #text input, hidden
echo #new line

#command substition, captures output of the below command within $() to be used as a variable.
passwordCheck=$(echo $password  | sha256sum -c ./setPassword/secret.txt)

#conditional statement  OK result of sha256sum outputof $password based on secret.txt. double brackets as testing a string captured within $passwordCheck
if [[ "$passwordCheck" = '-: OK' ]]
    then 
        echo "Access Granted" # prints if conditional statement is met 
        ./menu.sh
        exit 0 # exit code 0
        

#conditional statement checking FAILED result of sha256sum output of $password based on secret.txt. double brackets as testing a string captured within $passwordCheck
elif [[ "$passwordCheck" = '-: FAILED' ]]   
    then
        echo "Access Denied" # prints if conditional statement is met
        exit 1 # exit code 1
fi


