#!/bin/bash
set -e

# Check if 
UI_IS_DISABLED="WARNING: UI is disabled. Replace 127.0.0.1 with 0.0.0.0 to enabled it"
grep "127.0.0.1" ft_userdata/user_data/config.json &> /dev/null && echo ${UI_IS_DISABLED} 
grep "127.0.0.1" ft_userdata/docker-compose.yml  &> /dev/null && echo ${UI_IS_DISABLED}

cd ft_userdata
docker-compose up -d
