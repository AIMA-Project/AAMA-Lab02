#!/bin/bash

# Build the container for lab 2
docker build -t lab02-image .

# Launch the container and enter a bash shell
docker run --name lab02 -it lab02-image /bin/bash
