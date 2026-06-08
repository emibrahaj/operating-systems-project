#!/bin/bash
# Optimized makedict.sh for multiple files.
# Avoids useless cat and combines filtering steps.

E_BADARGS=85

if [ $# -lt 1 ]; then
    echo "Usage: $0 files-to-process"
    exit $E_BADARGS
fi

for file in "$@"; do
    if [ ! -r "$file" ]; then
        echo "Cannot read file: $file" >&2
        exit $E_BADARGS
    fi
done

tr '[:upper:]' '[:lower:]' "$@" |
    tr -c '[:alpha:]' '\n' |
    sort -u |
    grep -v '^$'

exit $?
