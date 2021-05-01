#!/bin/bash
set -e

D_STRATEGY="SampleStrategy"
D_START_DATE="20190801"
D_END_DATE="20191001"
D_TIMEFRAME="15m"
D_PAIR="ETH/BTC"
D_EXCHANGE="binance"

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

STRATEGY="$(ask_for_input "Enter your strategy" $D_STRATEGY)"
START_DATE="$(ask_for_input "Enter start date" $D_START_DATE)"
END_DATE="$(ask_for_input "Enter your end date" $D_END_DATE)"
TIMEFRAME="$(ask_for_input "Enter your timeframe" $D_TIMEFRAME)"
TIME_RANGE="${START_DATE}-${END_DATE}"
PAIR="$(ask_for_input "Pair" $D_PAIR)"
EXCHANGE="$(ask_for_input "Enter your exchange" $D_EXCHANGE)"

./download-data.sh ${PAIR} ${EXCHANGE} ${TIME_RANGE} ${TIMEFRAME}

echo -e "Backtesting is lanching for $TIME_RANGE"
cd ft_userdata
docker-compose run --rm freqtrade backtesting --config user_data/config.json --strategy ${STRATEGY} --timerange ${TIME_RANGE} -i ${TIMEFRAME} 

