#!/bin/bash
# Needed for Linux script compatibility

# Build the lab 2 container
docker build -t lab02-image .

# Launch the container and attach to it
docker run --name lab02 -it lab02-image /bin/bash
