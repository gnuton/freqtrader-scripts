#!/bin/bash
# download for the first time docker image
./update-docker-image.sh

# Create user directory structure
docker-compose run --rm freqtrade create-userdir --userdir user_data

# Create configuration - Requires answering interactive questions
docker-compose run --rm freqtrade new-config --config user_data/config.json

echo "The configuration has been stored at ft_userdata/user_data/config.json"
