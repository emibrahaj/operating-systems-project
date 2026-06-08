#! /bin/bash
# blank-rename.sh
#
# Substitutes underscores for blanks in all the filenames in a directory.

ONE=1                     # For getting singular/plural right.
number=0                  # Keeps track of how many files actually renamed.
FOUND=0                   # Successful return value.

for filename in *         # Traverse all files in directory.
do
     echo "$filename" | grep -q " "         # Check whether filename contains spaces.
     if [ $? -eq $FOUND ]
     then
       fname=$filename
       n=`echo $fname | sed -e "s/ /_/g"`   # Substitute underscore for blank.
       mv "$fname" "$n"                     # Rename the file.
       let "number += 1"
     fi
done

if [ "$number" -eq "$ONE" ]
then
 echo "$number file renamed."
else
 echo "$number files renamed."
fi

exit 0
