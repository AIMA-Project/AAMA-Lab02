import csv
import matplotlib.pyplot as plt
import numpy as np
from sys import argv

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


def extrapolate_point (target: int, a: np.float64, b: np.float64, c: np.float64, d: np.float64) -> float:
    # Get point on line using 3rd degree polynomial
    deg_three = (target * target * target) * a
    deg_two = (target * target) * b
    deg_one = target * c
    deg_zero = d
    return (deg_three + deg_two + deg_one + deg_zero)


def store_result (p: float, f_name: str) -> None:
    with open ("grades.txt", 'a') as results:
        results.write (f_name + ": " + str(p))


if __name__ == "__main__":
    x, y = get_test_results ()
    x_arr = np.array (x)
    y_arr = np.array (y)
    a, b, c, d = np.polyfit (x_arr, y, 3)

    p = extrapolate_point (10, a, b, c, d)
    store_result (p, argv[1])
