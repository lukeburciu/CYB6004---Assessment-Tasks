#!/bin/bash

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
  read -p "Press [Enter] key to continue..." fackEnterKey
}

#function for foldermaker
one(){
    ../'Week 2'/foldermaker.sh
	printf "\nClosed Create a folder\n"
        pause
}
#function for foldercopier
two(){
    ../'Week 2'/foldercopier.sh
	printf "\nClosed Folder Copier\n"
        pause
}
#function for setPassword
three(){
    ../'Week 2'/setPassword.sh
    printf "\nClosed set password\n"
        pause
}
#function for Calculator
four(){
    bc
    printf "\nClosed Calculator\n"
        pause
}
#function for Create Week Folders
five(){
    ./megafoldermaker.sh
    printf  "\nClosed Folder Maker\n"
        pause
}
#function for Check Filenamesr
six(){
    ./filenames.sh
    printf "\n Closed Check Filenames\n"
        pause
}
#function for Download a File
seven(){
    ./downloader.sh
    printf "\nClosed Web Downloader\n"
        pause
}
#function to display menus
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
	case $choice in
		1) one ;;
		2) two ;;
        3) three ;;
		4) four ;;
		5) five ;;
		6) six ;;
		7) seven ;;
        8) exit ;;
		*) echo -e "Error..." && sleep 15
	esac
}
 

#Main logic - infinite loop showing the menu and reading the options
passwordCheck
while true
do 
    show_menus
	read_options
done
