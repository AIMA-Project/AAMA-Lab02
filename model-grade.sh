#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid
MODEL_DIR=to_grade


for file in $MODEL_DIR/*.zip; do
	# Unzip student's assignment for grading
	7z x $file
	
	# Get training parameters used by student
	batch_size=$(sed '1!d' parameters.txt)
	max_file_size=$(sed '2!d' parameters.txt)
	filter_size=$(sed '3!d' parameters.txt)
	filter_stride=$(sed '4!d' parameters.txt)
	embed_size=$(sed '5!d' parameters.txt)
	channel_quant=$(sed '6!d' parameters.txt)
	
	# Do model training for an extra epoch
	python3 MalConv/train.py --batch_size $batch_size --epochs 11 --max_len $max_file_size \
	        --filter_size $filter_size --filter_stride $filter_stride --embd_size $embed_size \
			--num_channels $channel_quant $MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST
done