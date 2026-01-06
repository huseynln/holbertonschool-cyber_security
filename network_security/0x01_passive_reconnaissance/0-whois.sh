#!/bin/bash

# Check if domain argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

DOMAIN=$1

# Run whois and process with awk
whois "$DOMAIN" | awk '
BEGIN {
    section = ""
}

# Detect section headers
/Registrant Organization:/ { section = "registrant"; next }
/Admin Organization:/ { section = "admin"; next }
/Tech Organization:/ { section = "tech"; next }

# Process fields based on current section
section != "" {
    # Remove leading/trailing whitespace
    gsub(/^[ \t]+|[ \t]+$/, "")

    # Skip empty lines
    if (length($0) == 0) next

    # Extract field name and value
    if (match($0, /^([^:]+):[ \t]*(.*)$/, arr)) {
        field = arr[1]
        value = arr[2]

        # Map field names to CSV format
        if (field == "Registrant Organization" || field == "Admin Organization" || field == "Tech Organization") {
            print "Organization," value
        }
        else if (field == "Registrant Name" || field == "Admin Name" || field == "Tech Name") {
            print "Name," value
        }
        else if (field == "Registrant Street" || field == "Admin Street" || field == "Tech Street") {
            print "Street," value " "
        }
        else if (field == "Registrant City" || field == "Admin City" || field == "Tech City") {
            print "City," value
        }
        else if (field == "Registrant State/Province" || field == "Admin State/Province" || field == "Tech State/Province") {
            print "State/Province," value
        }
        else if (field == "Registrant Postal Code" || field == "Admin Postal Code" || field == "Tech Postal Code") {
            print "Postal Code," value
        }
        else if (field == "Registrant Country" || field == "Admin Country" || field == "Tech Country") {
            print "Country," value
        }
        else if (field == "Registrant Phone" || field == "Admin Phone" || field == "Tech Phone") {
            print "Phone," value
        }
        else if (field == "Registrant Phone Ext" || field == "Admin Phone Ext" || field == "Tech Phone Ext") {
            print "Phone Ext:," value
        }
        else if (field == "Registrant Fax" || field == "Admin Fax" || field == "Tech Fax") {
            print "Fax," value
        }
        else if (field == "Registrant Fax Ext" || field == "Admin Fax Ext" || field == "Tech Fax Ext") {
            print "Fax Ext:," value
        }
        else if (field == "Registrant Email" || field == "Admin Email" || field == "Tech Email") {
            print "Email," value
            section = ""  # End of section
        }
    }
}
' | head -c -1  # Remove last newline character
