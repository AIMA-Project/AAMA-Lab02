import csv
import matplotlib.pyplot as plt
import numpy as np

def get_test_results (f_name: str = "report.csv"):
    x_list: list(int) = []      # Holds epoch number
    y_list: list(float) = []    # Holds epoch verification accuracy
    with open (f_name) as report:
        report_read = csv.reader (report, delimiter = ',')
        for row in enumerate (report_read):
            # Skip first row that has the labels
            if (row[0] != 0):
                x_list.append (int(row[1][0]) + 1)
                y_list.append (float(row[1][3]))
    return x_list, y_list


if __name__ == "__main__":
    x, y = get_test_results ()
