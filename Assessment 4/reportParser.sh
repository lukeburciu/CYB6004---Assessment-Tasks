#!/bin/bash


#Awk is used for processing the output of information downloaded via urlCheck() and passed to a csv file in the same folder path.
  #$1 is Date, #$2 is Positives, $3 is total positives, $4 is the hash value.

awk 'BEGIN {
    FS = ",";
    printf("\033[33m%29-s %5-s %12-s %70-s %1s \033[0m\n", "| Date", "| Positives ", "| Total ", "| sha256 ", "|")
    print("________________________________________________________________________________________________________________________________")
    print
}
{
          printf("| \033[33m %25-s \033[0m | \033[35m %8-d \033[0m | \033[35m %8-d \033[0m | \033[35m %30-s \033[0m |\n", $1, $2, $3, $4)  
}
  END {
      print("________________________________________________________________________________________________________________________________");
}' $1