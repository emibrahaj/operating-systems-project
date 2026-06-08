#!/bin/bash
# collatz_instrumented.sh
#
# Instrumented Collatz script for Paper 1 analysis screenshots.
# The log messages show intermediate values and branch decisions.

MAX_ITERATIONS=200

h=${1:-$$}

echo "[LOG] Starting Collatz script"
echo "[LOG] Seed: $h"
echo "[LOG] Max iterations: $MAX_ITERATIONS"
echo
echo "C($h) -*- $MAX_ITERATIONS Iterations"
echo

for ((i=1; i<=MAX_ITERATIONS; i++))
do
  echo "[LOG] Iteration $i: current h=$h"
  printf "%7d" "$h"

  if (( h % 2 == 0 ))
  then
    echo " [LOG] even, next h=$((h / 2))"
    (( h /= 2 ))
  else
    echo " [LOG] odd, next h=$((h * 3 + 1))"
    (( h = h * 3 + 1 ))
  fi
done

echo
echo "[LOG] Finished Collatz script"

exit 0
