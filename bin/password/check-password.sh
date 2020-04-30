#!/bin/bash
# this script checks the sudo password

read -sp 'Password: ' PASSWORD

sudo -k

if sudo -lS &>/dev/null <<<"$PASSORD"; then
  echo 'correct'
else
  echo 'incorrect'
fi


