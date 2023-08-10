import csv
from numpy import std
from os import listdir, path
from sys import argv
from typing import List


def gen_assignment_list (dir: str) -> List[str]:
    '''
    Get a list of files in the directory specified and return it.
    '''
    ret_f_list = []
    for items in listdir (dir):
        if path.isfile (path.join (dir, items)):
            ret_f_list.append (path.join (dir, items))
    return ret_f_list


def grade_assignments (assignments: List[str]) -> None:
    '''

    '''
    for student_file in assignments:
        try:
            # Load in csv file for evaluation
            with open (student_file, newline = '') as s_file:
                csv_rows = []
                csv_data = csv.reader (s_file)
                # Convert CSV file to List[List[str]]
                for row in csv_data:
                    csv_rows.append (row)

            # Call functions to calculate "grades" for each attribute
            train_acc_mean = mean_value_grade ("train_acc", csv_rows)
            train_auc_mean = mean_value_grade ("train_auc", csv_rows)
            validation_acc_mean = mean_value_grade ("test_acc", csv_rows)
            validation_auc_mean = mean_value_grade ("test_auc", csv_rows)

            # Print mean of each grade
            print (student_file)
            print ("   Train Acc Mean: " + str (train_acc_mean))
            print ("   Train AUC Mean: " + str (train_auc_mean))
            print ("    Test Acc Mean: " + str (validation_acc_mean))
            print ("    Test AUC Mean: " + str (validation_auc_mean))
            print()
                
        # Error: What was opened probably wasn't a CSV (or has bad character encoding); print an
        #        error message and move on to next file in the list
        except UnicodeDecodeError:
            print ("File {bad_file} does not use proper encoding.".format (bad_file=student_file))


def standard_dev_grade (attribute: str, row_data: List[str]) -> float:
    for column in enumerate (row_data[0]):
        num_list = []
        std_dev = 0.0
        if column[1] == attribute:
            # Skip first row cause that's heading data
            for row in row_data[1:]:
                num_list.append (float (row[column[0]]))
            std_dev = std (num_list)
            break
    return std_dev


def mean_value_grade (attribute: str, row_data: List[str]) -> float:
    summation = 0.0
    for column in enumerate (row_data[0]):
        if column[1] == attribute:
            for row in row_data[1:]:
                summation = summation + float (row[column[0]])
            summation = summation / (len (row_data) - 1)
            break
    
    return summation


if __name__ == "__main__":
    submitted_assignments = gen_assignment_list (argv[1])
    grade_assignments (submitted_assignments)
