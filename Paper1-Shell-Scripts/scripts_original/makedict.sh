#!/bin/bash
# makedict.sh [make dictionary]
# Modification of /usr/sbin/mkdict (/usr/sbin/cracklib-forman) script.

# This script processes text files to produce a sorted list
#+ of words found in the files.

E_BADARGS=85

if [ ! -r "$1" ]       # Need at least one valid file argument.
then
  echo "Usage: $0 files-to-process"
  exit $E_BADARGS
fi

cat $* |
  tr A-Z a-z |
  tr ' ' '\012' |
  tr -c '\012a-z' '\012' |
  sort |
  uniq |
  grep -v '^#' |
  grep -v '^$'

exit $?
