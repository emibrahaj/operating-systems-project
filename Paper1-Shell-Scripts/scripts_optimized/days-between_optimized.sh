#!/bin/bash
# Optimized days-between.sh
# Uses GNU date instead of manual Gauss formula.

E_BADARGS=85
E_DATE=86

if [ $# -ne 2 ]; then
    echo "Usage: $(basename "$0") MM/DD/YYYY MM/DD/YYYY"
    exit $E_BADARGS
fi

date1_seconds=$(date -d "$1" +%s 2>/dev/null)
date2_seconds=$(date -d "$2" +%s 2>/dev/null)

if [ -z "$date1_seconds" ] || [ -z "$date2_seconds" ]; then
    echo "Invalid date format. Use MM/DD/YYYY."
    exit $E_DATE
fi

diff_seconds=$(( date1_seconds - date2_seconds ))

if [ "$diff_seconds" -lt 0 ]; then
    diff_seconds=$(( -diff_seconds ))
fi

days=$(( diff_seconds / 86400 ))

echo "$days"

exit 0
