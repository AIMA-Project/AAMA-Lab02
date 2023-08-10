#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=data/mal_train
BEN_TRAIN=data/ben_train
MAL_TEST=data/mal_valid
BEN_TEST=data/ben_valid


# Size of training batches (default 128); lower this number if training fails
BATCH_SIZE=16

# Number of iterations to train model over (default 10)
EPOCHS=10

# Largest contiguous block of bytes from an executable model will train on; files larger than this
# value will be truncated (default 16000000)
MAX_FILE_SIZE=64000000

# Width of filter for training (default 512)
FILTER_SIZE=512

# String of filter during training (default 512)
FILTER_STRIDE=512

# Size of embedding layers (default 8)
EMBED_SIZE=8

# Number of channels in output (default 128)
CHANNEL_QUANT=128


python3 train.py --batch_size $BATCH_SIZE --epochs $EPOCHS --max_len $MAX_FILE_SIZE --filter_size $FILTER_SIZE --filter_stride $FILTER_STRIDE --embd_size $EMBED_SIZE --num_channels $CHANNEL_QUANT $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST