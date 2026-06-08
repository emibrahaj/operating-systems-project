#!/bin/bash
# Optimized blank-rename.sh
# Replaces spaces with underscores using Bash parameter expansion.

ONE=1
number=0

shopt -s nullglob

for filename in *; do
    [ -f "$filename" ] || continue

    if [[ "$filename" == *" "* ]]; then
        newname="${filename// /_}"
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
