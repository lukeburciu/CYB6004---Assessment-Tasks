#!/bin/bash


#Awk is used for processing the output of information downloaded via urlCheck() and passed to a csv file in the same folder path.
  #$1 is Category, #$2 is Engine Name, $3 is Last engine update, $4 is the Current engine version, #$5 is the method (black/whitelist) and $#6 is the result (null if no report)..

awk 'BEGIN {
    FS = ",";
    print("______________________________________________________________________________________________________________________________________________________________________________")
    printf("\033[33m%29-s %29-s %12-s %10-s %21s %14s\033[0m\n", "  Category", "| Engine Name ", "| Last Update ", "| Engine Version ", "| Method ", "| Result ")
    print("______________________________________________________________________________________________________________________________________________________________________________")
    print
    }
    /blacklist/ {
            printf("| \033[33m %25-s \033[0m | \033[34m %25-s \033[0m | \033[32m %10-s \033[0m | \033[35m %25-s \033[0m | \033[36m %10-s \033[0m | \033[31m %45-d \033[0m |\n", $1, $2, $3, $4, $5, $6)  
    }
    END {
        print("____________________________________________________________________________________________________________________________________________________________________________");
    }' $1
