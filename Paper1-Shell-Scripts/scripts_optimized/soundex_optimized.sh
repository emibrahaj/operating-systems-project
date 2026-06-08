#!/bin/bash
# Optimized soundex.sh
# Reduces repeated pipelines and uses Bash string processing.

E_WRONGARGS=90

if [ $# -ne 1 ]; then
    echo "Usage: $(basename "$0") name"
    exit $E_WRONGARGS
fi

name="${1,,}"
first_letter="${name:0:1}"
prefix="${first_letter^^}"

rest="${name:1}"
previous_code=""
soundex_code=""

encode_char() {
    case "$1" in
        b|f|p|v) echo "1" ;;
        c|g|j|k|q|s|x|z) echo "2" ;;
        d|t) echo "3" ;;
        l) echo "4" ;;
        m|n) echo "5" ;;
        r) echo "6" ;;
        *) echo "" ;;
    esac
}

first_code=$(encode_char "$first_letter")

for ((i=0; i<${#rest}; i++)); do
    char="${rest:i:1}"
    code=$(encode_char "$char")

    if [ -n "$code" ] && [ "$code" != "$previous_code" ]; then
        if [ "$code" != "$first_code" ] || [ -n "$soundex_code" ]; then
            soundex_code+="$code"
        fi
    fi

    if [[ "$char" =~ [aeiouy] ]]; then
        previous_code=""
    elif [[ "$char" != "h" && "$char" != "w" ]]; then
        previous_code="$code"
    fi
done

soundex="${prefix}${soundex_code}000"
soundex="${soundex:0:4}"

echo
echo "Name = $1"
echo "Soundex = $soundex"
echo

exit 0
