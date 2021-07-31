#!/bin/bash
set -e

D_PAIR="ETH/BTC"
D_START_DATE="20190801"
#D_END_DATE="20191001" # End data is not needed data are fetched from start date to present 
D_TIMEFRAME="15m"
D_EXCHANGE="binance"
D_SKIP_FETCHING="n"

#COLORS
DEF_COLOR="\e[0m"
GREEN="\e[32m"

function ask_for_input() {
  local QUESTION=$1
  local D_VAL=$2
  local VAL=""
  read -p "${QUESTION} [${D_VAL}]: " VAL
  VAL=${VAL:-${D_VAL}}
  echo -e " - ${GREEN}${VAL}${DEF_COLOR}" >&2
  echo $VAL
}


if test "$#" -eq 0; then
  # No parameters. Ask user to fill them
  echo -e "No input data found!"
  echo -e "NOTE: You can launch this app with $0 $D_PAIR $D_EXCHANGE ${D_START_DATE}-${D_END_DATE} ${D_TIMEFRAME}"
  echo -e ""
  echo -e "Please fill in the following info"

  PAIR="$(ask_for_input "Pair" $D_PAIR)"
  START_DATE="$(ask_for_input "Enter start date" $D_START_DATE)"
  #END_DATE="$(ask_for_input "Enter your end date" $D_END_DATE)"
  TIMEFRAME="$(ask_for_input "Enter your timeframe" $D_TIMEFRAME)"
  EXCHANGE="$(ask_for_input "Enter your exchange" $D_EXCHANGE)"
  SKIP_FETCHING="$(ask_for_input "Do you wanna skip fetching data from the internet?" $D_SKIP_FETCHING)"
  TIME_RANGE="${START_DATE}-${END_DATE}"
elif test "$#" -eq 4; then
  # Takes input params from args
  PAIR=$1
  EXCHANGE=$2
  TIME_RANGE=$3
  TIMEFRAME=$4  
else
  echo -n "Invalid number of parameters"
  exit -1
fi
  
if [ "$SKIP_FETCHING" == "$D_SKIP_FETCHING" ]; then
  echo -e "Downloading data for $PAIR/$EXCHANGE/$TIME_RANGE"
  cd ft_userdata
  docker-compose run --rm freqtrade download-data --pairs ${PAIR} --exchange ${EXCHANGE} -t ${TIMEFRAME} -v --timerange ${TIME_RANGE}  
else
  echo -e "Data not fetched"
fi
