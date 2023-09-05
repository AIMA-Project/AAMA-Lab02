#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=data/mal_train
BEN_TRAIN=data/ben_train
MAL_TEST=data/mal_valid
BEN_TEST=data/ben_valid


# The number of files that will be used for each training batch (the training batch IS NOT the same
# as the epoch).
# Increasing: Grows the size of each batch used during training, decreasing training time.
# Decreasing: Lowers the size of each batch used during training, increasing training time.
#    Default: 16
#
# If training fails, there is a chance this number is too high. This is why the default is so low.
BATCH_SIZE=16

# Number of iterations to train model over.
# Increasing: Improves model performance (to a limit) at the cost of training time.
# Decreasing: Reduces training time but decreases model accuracy, especially at smaller values.
#    Default: 10
#
# For the lab DO NOT modify this value. Only a maximum of 10 epochs should be used.
EPOCHS=10

# The largest file size that will be used for training the model. Any file that is larger than this
# value will be truncated to this value.
# Increasing: Considers more file data for training at the cost of training time.
# Decreasing: Reduces training time but limits the files that can be used for training.
#    Default: 32000000
MAX_FILE_SIZE=32000000

# Width of the filter used during training. The filter acts as a spotlight that analyzes a portion
# of a bit stream. Modifying this value changes how "wide" that spotlight is.
# Increasing: Raises the memory requirements and training time, but increases model accuracy.
# Decreasing: Lowers model accuracy, but also lowers training time.
#    Default: 256
FILTER_SIZE=256

# Changes how far each filter moves in relation to the previous filter's position.
# Increasing: Increases the distance moved for each filter, lowering model performance but
#             reducing time needed for training.
# Decreasing: Creates a slower filter sweep that increases training time, but also increases
#             performance of the model.
#    Default: 1024
FILTER_STRIDE=1024

# The size of the embedding layer used with the model. This layer maps lower-complexity layers to
# higher-complexity layers in the network.
# Increasing: Improves model accuracy, but increases training time.
# Decreasing: Decreases model accuracy, but reduces training time.
#    Default: 4
EMBED_SIZE=4

# The number of channels that will be produced by the network. Changes the complexity of the model.
# Increasing: Increases model complexity at the expense of training time.
# Decreasing: Decreases the time required to train the model, but also reduces model performance.
#    Default: 128
CHANNEL_QUANT=128

# The command that does the actual training. Do not modify for the lab.
python3 MalConv/train.py --batch_size $BATCH_SIZE --epochs $EPOCHS --max_len $MAX_FILE_SIZE --filter_size $FILTER_SIZE --filter_stride $FILTER_STRIDE --embd_size $EMBED_SIZE --num_channels $CHANNEL_QUANT $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST

# Store the parameters used for training in a text file. This is needed for grading.
echo $BATCH_SIZE > parameters.txt
echo $MAX_FILE_SIZE >> parameters.txt
echo $FILTER_SIZE >> parameters.txt
echo $FILTER_STRING >> parameters.txt
echo $EMBED_SIZE >> parameters.txt
echo $CHANNEL_QUANT >> parameters.txt
