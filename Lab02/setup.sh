#!/bin/bash

# Sets up the required library files using venv and pip
python -m venv venv && source venv/bin/activate && pip install -r requirements.txt
