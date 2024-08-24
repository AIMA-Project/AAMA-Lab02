#!/bin/bash

# === Directories ==================================================================================

MAL_TRAIN=grade_data/mal_train
BEN_TRAIN=grade_data/ben_train
MAL_TEST=grade_data/mal_valid
BEN_TEST=grade_data/ben_valid
MODEL_DIR=to_grade

# Directory holding assignments doesn't exist yet
if [ ! -d $MODEL_DIR ]; then
	mkdir $MODEL_DIR
fi

# Directory holding grading test data doesn't exist yet
if [ ! -d "grade_data" ]; then
	mkdir -p $MAL_TRAIN
	mkdir $BEN_TRAIN
	mkdir $MAL_TEST
	mkdir $BEN_TEST
fi


# Iterate through and grade all assignments in to_grade/
for file in $MODEL_DIR/*.zip; do
	# Unzip student's assignment for grading
	echo "Extracting archive $file"
	7z x $file > /dev/null
	
	# Get training parameters used by student
	batch_size=$(sed '1!d' parameters.txt)
	max_file_size=$(sed '2!d' parameters.txt)
	
	# Do model training for an extra epoch
	echo "Training..."
	python3 MalConv/ContinueTraining.py --batch_size $batch_size --max_len $max_file_size \
	        --epochs 1 --model "MalConv" --checkpoint ./MalConv_*/epoch_9.checkpoint \
			$MAL_TRAIN $BEN_TRAIN $MAL_TEST $BEN_TEST
	
	# Grade model
	python3 Grading/grade.py ./long_train.csv $file

	# Clean up
	rm -rf ./MalConv_*/ parameters.txt report.csv ./long_train/ long_train.csv
done
