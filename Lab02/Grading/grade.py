import csv
from sys import argv


def load_test_acc (report: str) -> float:
    data = []
    # Open csv file with training results
    with open (report) as results_file:
        csv_parser = csv.reader (results_file, delimiter = ',')
        # Get second row of csv file, which should have training results
        for row in enumerate (csv_parser):
            if (row[0] == 0):
                continue
            data = row[1]
    # Return the fourth element of the results, which should be training accuracy
    return float (data[3])


if __name__ == "__main__":
    train_acc = load_test_acc (argv[1])
    with open ("grade_sheet.txt", "a") as append_grade:
        append_grade.write (argv[2] + ' ' + str (train_acc) + '\n')
