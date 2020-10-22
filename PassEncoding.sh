#!/bin/bash

ARRAY=(yescrypt gost-yescrypt scrypt bcrypt bcrypt-a sha512crypt sha256crypt md5crypt bsdicrypt descrypt nt)

echo "Questions,Answers,Wordlist,Encryption" > test.csv

for i in {1..25}
do
	pass=$(shuf -n 1 /usr/share/john/password.lst)
	rand=$((RANDOM%11))
	epass=$(mkpasswd $pass -m ${ARRAY[rand]})
	echo "kam$i:$epass,$pass,Wordlist=password.lst,Encryption=${ARRAY[rand]}" >> test.csv
done	
