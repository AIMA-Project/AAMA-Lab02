#!/bin/bash

# Build the container for lab 2
docker build -t lab02 .

# Launch the container and enter a bash shell
docker run -it lab02 bin/bash
