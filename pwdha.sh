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
# and save to DIGEST

DIGEST=$(echo -n $URI | openssl md5 -hmac $PLAIN -binary | openssl enc -base64 -A)

# Set hashed password length
# based on plain and prefix lengths

SIZE=$((${#PREFIX} + ${#PLAIN}))

if [[ $PLAIN =~ $RE ]]
then
  ALPHANUM=true
else 
  ALPHANUM=false
fi

apply_constraints () {
  local digest=$1
  local size=$2
  local alphanum=$3

  local start_size=$(($SIZE - 4))
  local result=${digest:0:$start_size}
  local extras=${digest:$start_size}
  echo $digest
  echo $result
  echo $extras
}

apply_constraints $DIGEST $SIZE $ALPHANUM

# String
text="Welcome"

# Set space as the delimiter
IFS=''

# Read the split words into an array
# based on space delimiter
read -ra newarr <<< "$text"

arr=$(echo "abcdefg" | grep -o .)
#echo $arr

