#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid
MODEL_DIR=to_grade


for file in $MODEL_DIR/*.zip; do
	7z e $file
	mv $MODEL_DIR/parameters.txt ./parameters.txt
	mv $MODEL_DIR/MalConv_* ./
	
	batch_size=$(sed '1!d' parameters.txt)
	max_file_size=$(sed '2!d' parameters.txt)
	filter_size=$(sed '3!d' parameters.txt)
	filter_stride=$(sed '4!d' parameters.txt)
	embed_size=$(sed '5!d' parameters.txt)
	channel_quant=$(sed '6!d' parameters.txt)
done