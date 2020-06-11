#!/usr/bin/python3
import hashlib
from itertools import chain, product

def bruteForce(charset, maxLength):
    return ( ''.join(candidate)
        for candidate in chain.from_iterable(product(charset, repeat=i)
        for i in range(1, maxLength + 1)))

for attempt in bruteForce(string.ascii_lowercase, 5):
    if matched:
        break


letterList = 'abcdefghijklmnopqrstuvwxyz'
fullList = []

for current in xrange(10):
    a = [i for i in letterList]
    for y in xrange(current):
        a = [x+i for i in letterList for x in a]
    fullList = letterList+a

h = hashlib.sha256(b'')

while 

print(f"Trying the following hash: {word}: ")
print(h.hexdigest() )

#open the wordlist
with open("wordlist.txt", "r") as wordlist:
    #repeat for each word
    for word in wordlist.readlines():
        word = word.strip()
        #hash the word
        wordlistHash = hashlib.sha256(word.encode("utf-8")).hexdigest()
        print(f"Trying password {word}:{wordlistHash}")
        #if the hash is the same as the correct password's hash then we have cracked the password!
        if(wordlistHash == passwordHash):
            print(f"Password has been cracked! It was {word}")
            break