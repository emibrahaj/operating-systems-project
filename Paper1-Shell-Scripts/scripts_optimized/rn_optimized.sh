#!/bin/bash
# Optimized rn.sh
# Renames files by replacing old pattern with new pattern using Bash built-ins.

ARGS=2
E_BADARGS=85
ONE=1

if [ $# -ne "$ARGS" ]; then
    echo "Usage: $(basename "$0") old-pattern new-pattern"
    echo "Example: ./rn_optimized.sh gif jpg"
    exit $E_BADARGS
fi

old_pattern=$1
new_pattern=$2
number=0

shopt -s nullglob

for filename in *"$old_pattern"*; do
    [ -f "$filename" ] || continue

    newname="${filename/$old_pattern/$new_pattern}"

    if [ "$filename" != "$newname" ]; then
        mv -- "$filename" "$newname"
        ((number++))
    fi
done

if [ "$number" -eq "$ONE" ]; then
    echo "$number file renamed."
else
    echo "$number files renamed."
fi

exit 0
