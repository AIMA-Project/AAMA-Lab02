#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid
MODEL_DIR=to_grade


# Low batch size to help with working on lower-end hardware
BATCH_SIZE=16

# Just train model for one epoch to gauge performance
EPOCHS=1

# Largest file size that will be trained on
MAX_FILE_SIZE=16000000

for file in $MODEL_DIR/*; do
	python3 MalConv/ContinueTraining.py --epochs $EPOCHS --batch_size $BATCH_SIZE --max_len $MAX_FILE_SIZE --checkpoint $file --model "MalConv" $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST
done