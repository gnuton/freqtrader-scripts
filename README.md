```
___________                       __                     .___            
\_   _____/______   ____  _______/  |_____________     __| _/___________ 
 |    __) \_  __ \_/ __ \/ ____/\   __\_  __ \__  \   / __ |/ __ \_  __ \
 |     \   |  | \/\  ___< <_|  | |  |  |  | \// __ \_/ /_/ \  ___/|  | \/
 \___  /   |__|    \___  >__   | |__|  |__|  (____  /\____ |\___  >__|   
     \/ Helper Scripts \/   |__|                  \/      \/    \/       
```
This repository contains basisc scripts to make freqtrader working on your local machine running docker.

These scripts have been tested on Linux and freqrader has been running from inside docker images.

## Scripts
Runs the task
```bash
quick-start.sh
```

The scripts support all the basic commands you may need during the BOT operations.
- Quick setup - Downloads the docker imanges, generates a basic config file and it runs it
- 
- Start - Starts a freqtrade instance
- Stop - Stop a freqtrade instance
- Update - Update freqtrade docker image
- Logs - Read the logs of the runing local instance
- Status - Checks the status of the running instance
- Backtesting - Runs freqtrade in docker for backtest strategies for a pair 
- Plot - Plots the strategy for a pair
- ... 
