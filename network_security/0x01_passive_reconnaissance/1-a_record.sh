#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

domain=$1

nslookup "$domain" 8.8.8.8
