#!/bin/bash
# this script gets the IP address of the router

ip route | grep "default" | awk '{print $3}' | uniq
