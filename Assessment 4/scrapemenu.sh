#!/bin/bash

# Source for inital menu schema:

#pause to go back into menu
pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey #prompts user to press enter 
}

#function for foldermaker
one(){
    ./scraper/scraper.sh #cd to Week 2 to get script to run
	printf "\nClosed scraper\n" #echos message when script exit
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
	echo -e "\e[1;35m 1. Check a hash\e[0m"
	echo -e "\e[1;35m 2. Check scanners\e[0m"
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
