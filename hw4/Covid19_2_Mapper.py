# """Covid19_1_Mapper.py"""
import sys
from datetime import date
args = sys.argv
try:
  startDate = args[1].split('-') #(YYYY-MM-DD)
  endDate = args[2].split('-') #(YYYY-MM-DD)

  startDate = list(map(int, startDate))
  endDate = list(map(int, endDate))
  startDate = date(startDate[0], startDate[1], startDate[2])
  endDate = date(endDate[0], endDate[1], endDate[2])
  if not date(2019, 12, 1) <= startDate <= date(2020, 4, 8):
    raise Exception('Startdate should be after Dec 2019 and before 8 April 2020')
  if not date(2019, 12, 1) <= endDate <= date(2020, 4, 8):
    raise Exception('Enddate should be after Dec 2019 and before 8 April 2020')
except Exception as error:
  print('Caught this error: ' + repr(error))

firstline = True
# with open('cse532/input/covid19_full_data.csv') as f:
#     for line in f:
for line in sys.stdin:
    if firstline:    #skip first line
        firstline = False
        continue

    line = line.split(',')
    givenDate = line[0].split('-')
    givenDate = list(map(int, givenDate))
    givenDate = date(givenDate[0], givenDate[1], givenDate[2])
    if startDate <= givenDate <= endDate:
        location = line[1]
        deaths = int(line[-1])
        print('%s\t%s' % (location, deaths))

