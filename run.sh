#!/bin/bash

python3 train.py --batch_size 16 --max_len 64000000 data/mal_train data/ben_train data/mal_valid data/ben_valid