#!/bin/bash


 #This function prints an Error
 printError()
 {
     echo -e "\033[31mERROR: \033[0m $1"
 }
 
 correctNumber=42

 #This function will check numbers for the criteria specified.
 getNumber()
 {
        
        while [[ $REPLY -ne $correctNumber ]]; do
            read -p "$1: "
            if [[ $REPLY -lt $2 ]] || [[ $REPLY -gt $3 ]]; then     #checks if not within 1 - 100
                printError "Input must be between $2 and $3"
            elif [[ $REPLY -gt 42 ]] && [[ $REPLY -le $3 ]]; then   #checks if within 43-100
                echo "Too High!"    
            elif [[ $REPLY -lt 42 ]] && [[ $REPLY -ge $2 ]]; then   #checks if within 1 - 41
                echo "Too Low!"
            fi     
        done     
 }

 getNumber "please type a number between 1 and 100" 1 100
 echo "Correct!"
 
