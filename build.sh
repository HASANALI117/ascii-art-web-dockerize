#!/bin/bash

# Build & tag Docker image from Dockerfile (current dir)
docker image build -f Dockerfile -t ascii-art-web-img .
echo

# List all images
docker images
echo

# Run detached container (port 8080 mapped) & name it
docker container run -p 8080:8080 --detach --name ascii-art-web-cont ascii-art-web-img
echo

# List all containers (including stopped)
docker ps -a
echo

# Inspect image labels (JSON format)
docker inspect --format='{{json .Config.Labels}}' ascii-art-web-img
echo

# Run bash shell inside container "ascii-art-web-cont"
# Check if OS is Windows
if [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ] || [ "$(expr substr $(uname -s) 1 10)" == "MINGW64_NT" ]; then
    # If Windows, use 'winpty' for 'docker exec'
    winpty docker exec -it ascii-art-web-cont //bin//sh
else
    # If not Windows, run 'docker exec' directly
    docker exec -it ascii-art-web-cont /bin/bash
fi
echo