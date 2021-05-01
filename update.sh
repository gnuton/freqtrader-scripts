#!/bin/bash
set -e
cd ft_userdata
# Download the latest image
docker-compose pull
# Restart the image
docker-compose up -d
