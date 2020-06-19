#!/bin/bash




pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey #prompts user to press enter 
}

# List of menu items specified for the scraper tool.
one(){
    ./commands/hashcheck.sh #
	printf "\nClosed Hash checker\n" 
        pause
}
#function for foldercopier
two(){
    ./commands/domainreport.sh 
	printf "\nClosed domain report\n" 
        pause
}
#function for setPassword
three(){
    ./commands/ipreport.sh 
    printf "\nClosed IP report\n" 
        pause
}

#function to display menu to user
show_menus() {
	
    echo -e "\e[1;33m \nSelect an option:\e[0m"
    echo
	echo -e "\e[1;35m 1. Check a hash\e[0m"
	echo -e "\e[1;35m 2. Get a domain report\e[0m"
    echo -e "\e[1;35m 3. Get IP address report\e[0m"
    echo
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
        8) exit ;;
		*) echo -e "\033[31mError...\033[0m" && sleep 100 # short error message for 100ms if outside of [1-8] is selected
	esac
}
 

#Main logic - infinite loop showing the menu and reading the options
while true # prompts the following once passwordCheck = Access Granted
do 
    show_menus  #uses funciton to show menu
	read_options #uses function to show options to interact with
done
