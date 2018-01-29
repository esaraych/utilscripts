#!/bin/bash
# Emulates the Linux command "cal -3" which is not available in OSX

case $# in
  0) month=$(date +%m) year=$(date +%Y);;
  2) month=$1 year=$2;;
  *) echo 1>&2 "Usage: $0 [MONTH YEAR]"; exit 3;;
esac
month=${month#"${month%%[!0]*}"}
if ((month == 1)); then
  previous_month=12 previous_year=$((year-1))
else
  previous_month=$((month-1)) previous_year=$year
fi
if ((month == 12)); then
  next_month=1 next_year=$((year+1))
else
  next_month=$((month+1)) next_year=$year
fi
printf "\n"
paste <(cal "$previous_month" "$previous_year" | awk '{printf "%-20s\n", $0}') \
      <(cal "$month" "$year" | awk '{printf "%-20s\n", $0}') \
      <(cal "$next_month" "$next_year")
printf "\nToday: `date '+%m/%d/%Y %H:%M:%S'`\n"
