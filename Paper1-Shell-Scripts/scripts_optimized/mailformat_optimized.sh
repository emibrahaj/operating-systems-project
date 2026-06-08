#!/bin/bash
# Optimized mailformat.sh
# Uses one awk process for cleaning, then fold for wrapping.

ARGS=1
E_BADARGS=85
E_NOFILE=86
MAXWIDTH=70

if [ $# -ne "$ARGS" ]; then
    echo "Usage: $(basename "$0") filename"
    exit $E_BADARGS
fi

if [ ! -f "$1" ]; then
    echo "File \"$1\" does not exist."
    exit $E_NOFILE
fi

awk '
{
    sub(/^>+/, "")
    sub(/^[ \t]+/, "")
    gsub(/\t/, " ")
    print
}
' "$1" | fold -s --width="$MAXWIDTH"

exit $?
