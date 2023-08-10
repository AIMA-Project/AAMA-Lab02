#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=data/mal_train
BEN_TRAIN=data/ben_train
MAL_TEST=data/mal_valid
BEN_TEST=data/ben_valid


# Size of training batches (default 128); lower this number if training fails
BATCH_SIZE=16

# Number of iterations to train model over (default 10)
EPOCHS=1

# Largest contiguous block of bytes from an executable model will train on; files larger than this
# value will be truncated (default 16000000)
MAX_FILE_SIZE=64000000


python3 ContinueTraining.py --epochs $EPOCHS --batch_size $BATCH_SIZE --max_len $MAX_FILE_SIZE --checkpoint "epoch_9.checkpoint" --model "MalConv" $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST