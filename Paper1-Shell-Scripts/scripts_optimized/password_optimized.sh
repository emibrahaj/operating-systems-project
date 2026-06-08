#!/bin/bash
# Optimized password.sh
# Uses /dev/urandom for stronger random password generation.

LENGTH=${1:-8}

if ! [[ "$LENGTH" =~ ^[0-9]+$ ]] || [ "$LENGTH" -le 0 ]; then
    echo "Usage: $(basename "$0") [positive_length]"
    exit 85
fi

tr -dc 'A-Za-z0-9' < /dev/urandom | head -c "$LENGTH"
echo

exit 0
