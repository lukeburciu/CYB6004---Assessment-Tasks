#!/bin/bash


# BEGIN, First rows of the output
# END, Final rows of the output  
# FS: Checks for ':' to delimit
# printf: header columns '%29' being 29 columns wide (for example), - being left aligned and %s for string, %d for digits.
# awk prints data from /etc/passwd
# /\/bin\/bash/ is a regular expression that filters for '/bin/bash' '\' is used to escape the '/' character.

awk 'BEGIN { 
        FS=":";
        printf("%29-s %12-s %12-s %34-s %24-s %1s \n", "| Username", "|  UserID", "|  GroupID", "|  Home", "|  Shell", "|")  
        printf("| \033[33m %25-s \033[0m | \033[35m %8-s \033[0m | \033[35m %8-s \033[0m | \033[35m %30-s \033[0m | \033[35m %20-s \033[0m |\n", echo,echo,echo,echo,echo)
        
    } 
    /\/bin\/bash/ {
        printf("| \033[33m %25-s \033[0m | \033[35m %8-d \033[0m | \033[35m %8-d \033[0m | \033[35m %30-s \033[0m | \033[35m %20-s \033[0m |\n", $1, $3, $4, $6, $7)  
    }
    END {
        print("________________________________________________________");
    }'  /etc/passwd
