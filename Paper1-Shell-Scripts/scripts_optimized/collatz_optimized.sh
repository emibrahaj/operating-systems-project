#!/bin/bash
# collatz_optimized.sh
#
# Optimized Collatz script for Paper 1 benchmarking.
# Adds a --silent mode so benchmarks can separate computation cost from output cost.

MAX_ITERATIONS=200
h=${1:-$$}
mode=${2:-normal}

for ((i=1; i<=MAX_ITERATIONS; i++))
do
    if [ "$mode" != "--silent" ]
    then
        printf "%7d" "$h"
        if (( i % 10 == 0 ))
        then
            echo
        fi
    fi

    if (( h % 2 == 0 ))
    then
        (( h /= 2 ))
    else
        (( h = h * 3 + 1 ))
    fi
done

[ "$mode" != "--silent" ] && echo

exit 0
