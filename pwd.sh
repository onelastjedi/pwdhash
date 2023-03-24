#!/bin/bash

# Hashed password is a
# combination of page URI
# and plaintext password

# Get user input and 
# save to URI, PLAIN

read -p "Domain: " URI
echo "Password: "
read -s PLAIN

# Use openssl and some utility
# functions to get hashed password
