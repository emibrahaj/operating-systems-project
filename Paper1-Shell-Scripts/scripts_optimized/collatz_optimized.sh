#!/bin/bash
# Optimized collatz.sh
# Adds silent mode so benchmarking can measure computation separately from printing.

MAX_ITERATIONS=${MAX_ITERATIONS:-200}
h=${1:-$$}
mode=${2:-normal}

if [ "$mode" != "--silent" ]; then
    echo
    echo "C($h) -*- $MAX_ITERATIONS Iterations"
    echo
fi

for ((i=1; i<=MAX_ITERATIONS; i++)); do
    if [ "$mode" != "--silent" ]; then
        printf "%7d" "$h"

        if (( i % 10 == 0 )); then
            echo
        fi
    fi

    if (( h % 2 == 0 )); then
        (( h /= 2 ))
    else
        (( h = h * 3 + 1 ))
    fi
done

if [ "$mode" != "--silent" ]; then
    echo
fi

exit 0
