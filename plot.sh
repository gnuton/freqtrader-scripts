#!/bin/bash
set -e

D_STRATEGY="SampleStrategy"
D_START_DATE="$(date +'%Y%m%d' --date='-1 month')"
D_END_DATE="$(date +'%Y%m%d')" #NOW
D_TIMEFRAME="15m"
D_PAIR="BTC/USDT"
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

echo "Available Strategies"
for f in ./ft_userdata/user_data/strategies/*.py; do
  printf " - ${GREEN}${f}${DEF_COLOR}\n" >&2
done

STRATEGY="$(ask_for_input "Please choose one of the above available strategies" $D_STRATEGY)"
START_DATE="$(ask_for_input "Enter start date" $D_START_DATE)"
END_DATE="$(ask_for_input "Enter your end date" $D_END_DATE)"
TIMEFRAME="$(ask_for_input "Enter your timeframe" $D_TIMEFRAME)"
TIME_RANGE="${START_DATE}-${END_DATE}"
PAIR="$(ask_for_input "Pair" $D_PAIR)"
EXCHANGE="$(ask_for_input "Enter your exchange" $D_EXCHANGE)"

./download-data.sh ${PAIR} ${EXCHANGE} ${TIME_RANGE} ${TIMEFRAME}

echo -e "Backtesting is lanching for $TIME_RANGE"
cd ft_userdata
docker-compose -f docker-compose.yml -f docker-compose.plot.yml run --rm freqtrade plot-dataframe --strategy ${STRATEGY} --timerange ${TIME_RANGE} -i ${TIMEFRAME} -p ${PAIR}
echo -e "The plot has been created in ft_userdata/user_data/plot/. Please open it with your browser."
ls user_data/plot/
