#!/bin/bash
# this script checks the sudo password
# NOTE: it doesn't check if passwords match

read -sp 'Password: ' PASSWORD
echo -e "$PASSWORD\n$PASSWORD" | passwd pi
