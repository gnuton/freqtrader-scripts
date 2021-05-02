#!/bin/bash
set -e
TARGET_DIR="$(pwd)/ft_userdata/user_data"
TEMP_DIR="/tmp/freq-strategies-$(uuid)"
FREQ_STRATEGIES_URL="https://github.com/freqtrade/freqtrade-strategies.git"

mkdir -p $TEMP_DIR
cd $TEMP_DIR
echo "Downloading strategies from $FREQ_STRATEGIES_URL to temp dir $TEMP_DIR"
git clone $FREQ_STRATEGIES_URL

echo "Copying strategies and hyperopts to $TARGET_DIR"
cd freqtrade-strategies/user_data
cp -R strategies/* $TARGET_DIR/strategies
cp -R hyperopts/* $TARGET_DIR/hyperopts

echo "Cleaning up temporary files.."
rm -Rf $TEMP_DIR
