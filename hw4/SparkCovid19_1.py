from pyspark import SparkContext
sc = SparkContext()

from datetime import date
import sys
args = sys.argv
inputpath = args[1]
outputpath = args[4]
try:
  startDate = args[2].split('-') #(YYYY-MM-DD)
  endDate = args[3].split('-') #(YYYY-MM-DD)

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

csvPath = 'hdfs://localhost:9000' + inputpath
mainRDD = sc.textFile(csvPath)
header = mainRDD.first() #extract header
mainRDD = mainRDD.filter(lambda row: row != header)   #filter out header

def filterfn(record):
  line = record.split(',')
  givenDate = line[0].split('-') # 1/27/2020
  givenDate = list(map(int, givenDate))
  givenDate = date(givenDate[0], givenDate[1], givenDate[2])
  if startDate <= givenDate <= endDate:
    return True
  else:
    return False

def mapfn(record):
  line = record.split(',')
  location = line[1]
  deaths = int(line[-1])
  return (location, deaths)

res = mainRDD.filter(lambda record: filterfn(record)).map(lambda record: mapfn(record)).reduceByKey(lambda a,b:a+b)
res.collect()
res.saveAsTextFile('hdfs://localhost:9000' + outputpath)