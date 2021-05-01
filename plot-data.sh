#!/bin/bash
set -e

D_STRATEGY="SampleStrategy"
D_PAIR="ETH/BTC"
D_START_DATE="20190801"
D_END_DATE="20191001"
D_TIMEFRAME="15m"

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
  echo -e "NOTE: You can launch this app with $0 $D_STRATEGY $D_PAIR ${D_START_DATE}-${D_END_DATE}"
  echo -e ""
  echo -e "Please fill in the following info"

  STRATEGY="$(ask_for_input "Enter your strategy" $D_PAIR)"
  PAIR="$(ask_for_input "Pair" $D_PAIR)"
  START_DATE="$(ask_for_input "Enter start date" $D_START_DATE)"
  END_DATE="$(ask_for_input "Enter your end date" $D_END_DATE)"
  TIME_RANGE="${START_DATE}-${END_DATE}"
elif test "$#" -eq 3; then
  # Takes input params from args
  STRATEGY=$1
  PAIR=$2
  TIME_RANGE=$3
else
  echo -n "Invalid number of parameters"
  exit -1
fi
  

echo -e "Downloading data for $STRATEGY/$PAIR/$TIME_RANGE"
cd ft_userdata
docker-compose run --rm freqtrade plot-dataframe --strategy $STRATEGY -p $PAIR --timerange=$TIME_RANGE

