#!/bin/bash

PASSWD=/etc/passwd
RED='\033[0;41;30m'
STD='\033[0;0;39m'

pause(){
  read -p "Press [Enter] key to continue..." fackEnterKey
}

one(){
    ./foldermaker.sh
	echo "Create a folder"
        pause
}
# 
two(){
    ./foldercopier.sh
	echo "Copy a folder"
        pause
}

three (){
    ./setPassword.sh
    echo "Set a password"
        pause
}
# function to display menus
show_menus() {
	clear
    echo "Select an option:"
    echo
	echo "1. Create a folder"
	echo "2. Copy a folder"
    echo "3. Set a password"
	echo "4. Exit"
}

#show menu with options
read_options(){
	local choice
	read -p "Enter choice [ 1 - 4 ] " choice
	case $choice in
		1) one ;;
		2) two ;;
        3) three ;;
		4) exit 0;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}
 
# ----------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
 

#Main logic - infinite loop showing the menu and reading the options
while true
do 
	show_menus
	read_options
done