#!/bin/bash

# Check if subnetwork argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <subnetwork>"
    echo "Example: $0 192.168.65.0/24"
    exit 1
fi

# Run nmap with ARP scan
# -PR: ARP ping scan
# -sn: No port scan (host discovery only)
sudo nmap -PR -sn "$1"
