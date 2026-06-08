#!/bin/bash
# makedict_optimized.sh
# Optimized dictionary generator.

E_BADARGS=85

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 files-to-process"
  exit $E_BADARGS
fi

for file in "$@"; do
  if [ ! -r "$file" ]; then
    echo "Error: Cannot read file '$file'"
    exit $E_BADARGS
  fi
done

cat "$@" |
  tr '[:upper:]' '[:lower:]' |
  tr -c '[:alpha:]\n' '\n' |
  grep -v '^#' |
  grep -v '^$' |
  sort -u

exit $?

