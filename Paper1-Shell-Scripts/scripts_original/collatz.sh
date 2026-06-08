#!/bin/bash
# collatz.sh
#
# The notorious "hailstone" or Collatz series.
# 1) Get the integer seed from the command line.
# 2) Print the current number.
# 3) If the number is even, divide it by 2.
# 4) If the number is odd, multiply it by 3 and add 1.
# 5) Repeat for the configured number of iterations.

MAX_ITERATIONS=200

h=${1:-$$}                      # Use the process ID as seed if not specified.

echo
echo "C($h) -*- $MAX_ITERATIONS Iterations"
echo

for ((i=1; i<=MAX_ITERATIONS; i++))
do
  COLWIDTH=%7d
  printf $COLWIDTH $h

  let "remainder = h % 2"
  if [ "$remainder" -eq 0 ]     # Even?
  then
    let "h /= 2"
  else
    let "h = h*3 + 1"
  fi

  COLUMNS=10                    # Output 10 values per line.
  let "line_break = i % $COLUMNS"
  if [ "$line_break" -eq 0 ]
  then
    echo
  fi
done

echo

exit 0
