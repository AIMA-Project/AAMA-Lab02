import csv
import matplotlib.pyplot as plt
import numpy as np

def read_csv (f_name: str = "report.csv"):
    with open (f_name) as report:
        report_read = csv.reader (report, delimiter = ',')
        for row in report_read:
            print (row)


if __name__ == "__main__":
    read_csv ()
