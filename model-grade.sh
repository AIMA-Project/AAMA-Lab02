#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid


# Low batch size to help with working on lower-end hardware
BATCH_SIZE=16

# Just train model for one epoch to gauge performance
EPOCHS=1

# Largest file size that will be trained on
MAX_FILE_SIZE=16000000


python3 ContinueTraining.py --epochs $EPOCHS --batch_size $BATCH_SIZE --max_len $MAX_FILE_SIZE --checkpoint "epoch_9.checkpoint" --model "MalConv" $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST