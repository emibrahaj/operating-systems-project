#!/bin/bash
# life.sh: "Life in the Slow Lane"
# Bash script version of John Conway's Game of Life.

SURVIVE=2
BIRTH=3

startfile=gen0

if [ -n "$1" ]
then
  startfile="$1"
fi

E_NOSTARTFILE=86

if [ ! -e "$startfile" ]
then
  echo "Startfile \"$startfile\" missing!"
  exit $E_NOSTARTFILE
fi

ALIVE1=.
DEAD1=_

ROWS=10
COLS=10

GENERATIONS=10
NONE_ALIVE=85
DELAY=2

TRUE=0
FALSE=1
ALIVE=0
DEAD=1

avar=
generation=0

let "cells = $ROWS * $COLS"

declare -a initial
declare -a current

display ()
{
  alive=0

  declare -a arr
  arr=( `echo "$1"` )

  element_count=${#arr[*]}

  local i
  local rowcheck

  for ((i=0; i<$element_count; i++))
  do
    let "rowcheck = $i % COLS"

    if [ "$rowcheck" -eq 0 ]
    then
      echo
      echo -n " "
    fi

    cell=${arr[i]}

    if [ "$cell" = . ]
    then
      let "alive += 1"
    fi

    echo -n "$cell" | sed -e 's/_/ /g'
  done

  return
}

IsValid ()
{
  if [ -z "$1" -o -z "$2" ]
  then
    return $FALSE
  fi

  local row
  local lower_limit=0
  local upper_limit
  local left
  local right

  let "upper_limit = $ROWS * $COLS - 1"

  if [ "$1" -lt "$lower_limit" -o "$1" -gt "$upper_limit" ]
  then
    return $FALSE
  fi

  row=$2

  let "left = $row * $COLS"
  let "right = $left + $COLS - 1"

  if [ "$1" -lt "$left" -o "$1" -gt "$right" ]
  then
    return $FALSE
  fi

  return $TRUE
}

IsAlive ()
{
  GetCount "$1" $2
  local nhbd=$?

  if [ "$nhbd" -eq "$BIRTH" ]
  then
    return $ALIVE
  fi

  if [ "$3" = "." -a "$nhbd" -eq "$SURVIVE" ]
  then
    return $ALIVE
  fi

  return $DEAD
}

GetCount ()
{
  local cell_number=$2
  local array
  local top
  local center
  local bottom
  local r
  local row
  local i
  local t_top
  local t_cen
  local t_bot
  local count=0
  local ROW_NHBD=3

  array=( `echo "$1"` )

  let "top = $cell_number - $COLS - 1"
  let "center = $cell_number - 1"
  let "bottom = $cell_number + $COLS - 1"
  let "r = $cell_number / $COLS"

  for ((i=0; i<$ROW_NHBD; i++))
  do
    let "t_top = $top + $i"
    let "t_cen = $center + $i"
    let "t_bot = $bottom + $i"

    let "row = $r"
    IsValid $t_cen $row

    if [ $? -eq "$TRUE" ]
    then
      if [ ${array[$t_cen]} = "$ALIVE1" ]
      then
        let "count += 1"
      fi
    fi

    let "row = $r - 1"
    IsValid $t_top $row

    if [ $? -eq "$TRUE" ]
    then
      if [ ${array[$t_top]} = "$ALIVE1" ]
      then
        let "count += 1"
      fi
    fi

    let "row = $r + 1"
    IsValid $t_bot $row

    if [ $? -eq "$TRUE" ]
    then
      if [ ${array[$t_bot]} = "$ALIVE1" ]
      then
        let "count += 1"
      fi
    fi
  done

  if [ ${array[$cell_number]} = "$ALIVE1" ]
  then
    let "count -= 1"
  fi

  return $count
}

next_gen ()
{
  local array
  local i=0

  array=( `echo "$1"` )

  while [ "$i" -lt "$cells" ]
  do
    IsAlive "$1" $i ${array[$i]}

    if [ $? -eq "$ALIVE" ]
    then
      array[$i]=.
    else
      array[$i]="_"
    fi

    let "i += 1"
  done

  avar=`echo ${array[@]}`
  display "$avar"

  echo
  echo
  echo "Generation $generation - $alive alive"

  if [ "$alive" -eq 0 ]
  then
    echo
    echo "Premature exit: no more cells alive!"
    exit $NONE_ALIVE
  fi
}

# main

initial=( `cat "$startfile" | sed -e '/#/d' | tr -d '\n' | \
sed -e 's/\./\. /g' -e 's/_/_ /g'` )

clear

echo
setterm -reverse on
echo "======================="
setterm -reverse off
echo " $GENERATIONS generations"
echo " of"
echo "\"Life in the Slow Lane\""
setterm -reverse on
echo "======================="
setterm -reverse off

sleep $DELAY

Gen0=`echo ${initial[@]}`
display "$Gen0"

echo
echo
echo "Generation $generation - $alive alive"

sleep $DELAY

let "generation += 1"

echo

Cur=`echo ${initial[@]}`
next_gen "$Cur"

sleep $DELAY

let "generation += 1"

while [ "$generation" -le "$GENERATIONS" ]
do
  Cur="$avar"
  next_gen "$Cur"
  let "generation += 1"
  sleep $DELAY
done

echo

exit 0
