#!/bin/bash

# Hashed password is a
# combination of page URI
# and plaintext password

PREFIX='@@'
RE='[^a-zA-Z\d\s:]'

# Get user input and 
# save to URI, PLAIN

read -p "Domain: " URI
echo "Password: "
read -s PLAIN

# Use openssl to get hashed password
# and save to BASE64

BASE64=$(echo -n $URI | openssl md5 -hmac $PLAIN -binary | openssl enc -base64 -A)

# Set hashed password length
# based on plain and prefix lengths

SIZE=$((${#PREFIX} + ${#PLAIN}))

if [[ $PLAIN =~ $RE ]]
then
  NONALPHA=true
else 
  NONALPHA=false
fi
