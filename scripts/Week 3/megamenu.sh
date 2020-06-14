#!/bin/bash

# Source for inital menu schema:

# Linux Shell Scripting Tutorial - A Beginners Handbook (2016). Menu driven scripts. Cyberciti https://bash.cyberciti.biz/guide/Menu_driven_scripts

#password check integrated into script using week2 PasswordCheck.sh script. changed script to return instead of exit 0
passwordCheck() {

        echo -n "Hi $USER, please enter secret password: " #Posts message asking for password
        read -s  password  #text input, hidden
        echo #new line

        #command substition, captures output of the below command within $() to be used as a variable.
        passwordCheck=$(echo $password  | sha256sum -c ../'Week 2'/setPassword/secret.txt)

        #conditional statement  OK result of sha256sum outputof $password based on secret.txt. double brackets as testing a string captured within $passwordCheck
        if [[ "$passwordCheck" = '-: OK' ]]
            then 
                echo -e "\e[1;32m Access Granted\e[0m" # prints if conditional statement is met 
                return # returns to script
                

        #conditional statement checking FAILED result of sha256sum output of $password based on secret.txt. double brackets as testing a string captured within $passwordCheck
        elif [[ "$passwordCheck" = '-: FAILED' ]]   
            then
                echo -e "\e[1;31m Access Denied\e[0m" # prints if conditional statement is met
                exit 1 # exit code 1, exits to bash
        fi


}

#pause to go back into menu
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey #prompts user to press enter 
}

#function for foldermaker
one(){
    ../'Week 2'/foldermaker.sh #cd to Week 2 to get script to run
	printf "\nClosed Create a folder\n" #echos message when script exit
        pause
}
#function for foldercopier
two(){
    ../'Week 2'/foldercopier.sh #cd to Week 2 to get script to run
	printf "\nClosed Folder Copier\n" #echos message when script exit
        pause
}
#function for setPassword
three(){
    ../'Week 2'/setPassword.sh #cd to Week 2 to get script to run
    printf "\nClosed set password\n" #echos message when script exit
        pause
}
#function for Calculator
four(){
    bc                         #bc opens calculator
    printf "\nClosed Calculator\n" #echos message when script exit
        pause
}
#function for Create Week Folders
five(){
    ./megafoldermaker.sh      #runs script in folder
    printf  "\nClosed Folder Maker\n" #echos message when script exit
        pause
}
#function for Check Filenamesr
six(){
    ./filenames.sh            #runs script in folder
    printf "\n Closed Check Filenames\n" #echos message when script exit
        pause
}
#function for Download a File
seven(){
    ./downloader.sh           #runs script in folder
    printf "\nClosed Web Downloader\n" #echos message when script exit
        pause
}
#function to display menu to user
show_menus() {
	
    echo -e "\e[1;33m \nSelect an option:\e[0m"
    echo
	echo -e "\e[1;35m 1. Create a folder\e[0m"
	echo -e "\e[1;35m 2. Copy a folder\e[0m"
    echo -e "\e[1;35m 3. Set a password\e[0m"
	echo -e "\e[1;35m 4. Calculator\e[0m"
	echo -e "\e[1;35m 5. Create Week Folders\e[0m"
	echo -e "\e[1;35m 6. Check Filenames\e[0m"
	echo -e "\e[1;35m 7. Download a File\e[0m"
    echo -e "\e[1;31m 8. Exit\e[0m"
}

#show menu with options
read_options(){
	local choice
	read -p "Enter choice [ 1 - 8 ] " choice
	case $choice in # when choices in show_menu are selected (from 1 - 8), read options will then run the respective function corresponding with the $choice.
		1) one ;;
		2) two ;;
        3) three ;;
		4) four ;;
		5) five ;;
		6) six ;;
		7) seven ;;
        8) exit ;;
		*) echo -e "\033[31mError...\033[0m" && sleep 100 # short error message for 100ms if outside of [1-8] is selected
	esac
}
 

#Main logic - infinite loop showing the menu and reading the options
passwordCheck # runs passwordCheck to prompt user for the password (script starts here)
while true # prompts the following once passwordCheck = Access Granted
do 
    show_menus  #uses funciton to show menu
	read_options #uses function to show options to interact with
done
