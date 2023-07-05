import csv
import os
print (os.getcwd())
inputFile = 'coverage/test_cov_console.csv'
lis = list(csv.reader(open(inputFile)))
print('Coverage: ', lis[-1][3])


