#!/bin/bash
# days-between.sh: Number of days between two dates.
# Usage: ./days-between.sh [M]M/[D]D/YYYY [M]M/[D]D/YYYY

ARGS=2
E_PARAM_ERR=85

REFYR=1600
CENTURY=100
DIY=365
ADJ_DIY=367
MIY=12
DIM=31
LEAPCYCLE=4

MAXRETVAL=255

diff=
value=
day=
month=
year=

Param_Error ()
{
  echo "Usage: `basename $0` [M]M/[D]D/YYYY [M]M/[D]D/YYYY"
  echo "       (date must be after 1/3/1600)"
  exit $E_PARAM_ERR
}

Parse_Date ()
{
  month=${1%%/**}
  dm=${1%/**}
  day=${dm#*/}
  let "year = `basename $1`"
}

check_date ()
{
  [ "$day" -gt "$DIM" ] || [ "$month" -gt "$MIY" ] || \
  [ "$year" -lt "$REFYR" ] && Param_Error
}

strip_leading_zero ()
{
  return ${1#0}
}

day_index ()
{
  day=$1
  month=$2
  year=$3

  let "month = $month - 2"

  if [ "$month" -le 0 ]
  then
    let "month += 12"
    let "year -= 1"
  fi

  let "year -= $REFYR"
  let "indexyr = $year / $CENTURY"

  let "Days = $DIY*$year + $year/$LEAPCYCLE - $indexyr \
       + $indexyr/$LEAPCYCLE + $ADJ_DIY*$month/$MIY + $day - $DIM"

  echo $Days
}

calculate_difference ()
{
  let "diff = $1 - $2"
}

abs ()
{
  if [ "$1" -lt 0 ]
  then
    let "value = 0 - $1"
  else
    let "value = $1"
  fi
}

if [ $# -ne "$ARGS" ]
then
  Param_Error
fi

Parse_Date $1
check_date $day $month $year

strip_leading_zero $day
day=$?

strip_leading_zero $month
month=$?

let "date1 = `day_index $day $month $year`"

Parse_Date $2
check_date $day $month $year

strip_leading_zero $day
day=$?

strip_leading_zero $month
month=$?

date2=$(day_index $day $month $year)

calculate_difference $date1 $date2
abs $diff
diff=$value

echo $diff

exit 0
