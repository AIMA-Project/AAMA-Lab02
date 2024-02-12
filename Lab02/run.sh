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

# The largest file size that will be used for training the model. Any file that is larger than this
# value will be truncated to this value.
# Increasing: Considers more file data for training at the cost of training time.
# Decreasing: Reduces training time but limits the files that can be used for training.
#    Default: 32000000
MAX_FILE_SIZE=16000000

#Remove an previous training data before starting this training.
echo "Preparing to train..."
rm -rf ./MalConv_* ./parameters.txt ./*.zip > /dev/null

# The command that does the actual training. Do not modify for the lab.
python3 MalConv/train.py --batch_size $BATCH_SIZE --epochs 10 --max_len $MAX_FILE_SIZE \
		$MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST

# Store the parameters used for training in a text file. This is needed for grading.
echo $BATCH_SIZE > parameters.txt
echo $MAX_FILE_SIZE >> parameters.txt

# Create a zip file with the results and parameters
echo "Creating assignment archive..."
7z a assignment.zip parameters.txt MalConv_* > /dev/null
