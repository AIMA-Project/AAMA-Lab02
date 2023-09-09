#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid
MODEL_DIR=to_grade


for file in $MODEL_DIR/*.zip; do
	# Unzip student's assignment for grading
	echo "Extracting archive $file"
	7z x $file > /dev/null
	
	# Get training parameters used by student
	batch_size=$(sed '1!d' parameters.txt)
	max_file_size=$(sed '2!d' parameters.txt)
	
	# Do model training for an extra epoch
	echo "Training..."
	python3 MalConv/ContinueTraining.py --batch_size $batch_size --epochs 11 --model "MalConv" \
	        --max_len $max_file_size --epoch ./MalConv_*/epoch_9.checkpoint \
			$MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST
	
	# Move model report to current dir. and grade it
	mv ./MalConv_*/*.csv ./report.csv

	python3 Grading/grade.py $file

	# Clean up
	rm -rf ./MalConv_*/ parameters.txt report.csv
done
