#!/bin/bash

# Build the container for lab 2
sudo docker build -t lab02 .

# Launch the container and enter a bash shell
sudo docker run --name lab2 -it lab02
