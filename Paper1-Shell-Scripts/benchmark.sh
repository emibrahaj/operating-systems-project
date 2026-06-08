#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 2 ]; then
    echo "Usage: $0 script-name command [args...]"
    echo "Example: $0 collatz ./scripts_original/collatz.sh 27"
    exit 1
fi

name="$1"
shift

mkdir -p results/time results/strace results/perf

/usr/bin/time -v "$@" > "results/time/${name}_time.txt" 2>&1

if command -v strace >/dev/null 2>&1; then
    strace -c "$@" > "results/strace/${name}_strace.txt" 2>&1
else
    echo "strace not available" > "results/strace/${name}_strace.txt"
fi

if command -v perf >/dev/null 2>&1; then
    perf stat "$@" > "results/perf/${name}_perf.txt" 2>&1
else
    echo "perf not available" > "results/perf/${name}_perf.txt"
fi
