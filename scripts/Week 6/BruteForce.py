#!/usr/bin/python3

import string #imports string library from python
import itertools #import itertools
import hashlib #imports hashlib for use in the script

#inspiration for letter generator taken from:
    # Brute-Force Password Cracker (2020). main.py. CyanCoding. https://github.com/CyanCoding/Brute-Force-Password-Cracker/tree/master/Python

passwordHash = "8b7df143d91c716ecfa5fc1730022f6b421b05cedee8fd52b1fc65a96030ad52" # Supplied password hash to fit script
alphanum = string.ascii_lowercase + string.digits # specifies [a-z][0-9] as the character sets
for i in range(1, 5):   #loop through within range of 4 letters.
    for letter in itertools.product(alphanum, repeat=i): # for the letter defined within range, repeat as many times as fits range(a, b)
        letter = ''.join(letter)                        #  appends new letter if a -> 9  is looped (e.g: aa,... aaa.. aab....aa9 etc etc.. to 9999)
        letterHash = hashlib.sha256(letter.encode("utf-8")).hexdigest() # Hashes above output into sha256sum
        if(letterHash == passwordHash):     #if function to see if letterhash = password hash
            print(f"Password has been cracked! It was '{letter}' !!")   #will print the following if true, break point
            break
        else:                                                           # will print the following if false
            print(f"Trying password {letter}: {letterHash}")            
