from pyspark import SparkContext
sc = SparkContext()

from datetime import date
import sys
args = sys.argv
inputpath = args[1]
cachepath = args[1]
outputpath = args[3]

csvPath = 'hdfs://localhost:9000' + inputpath
mainRDD = sc.textFile(csvPath)
header = mainRDD.first() #extract header
mainRDD = mainRDD.filter(lambda row: row != header)   #filter out header

def modify(current_word, current_count):
  pop = getPop(current_word)
  if pop:
      current_count2 = (current_count / pop) * 1000000
      return (current_word, current_count2)
  return None

csvPath = 'hdfs://localhost:9000' + cachepath
popRDD = sc.textFile(csvPath).collect()
popRDD = sc.broadcast(popRDD).value

def checkPop(row, current_word):
    line = row.split(',')
    if current_word == line[1] or current_word == line[2]:
        return row.split(',')[-1].strip('\n')
    return None

# def getPop(current_word):
#     pop = popRDD.flatMap(lambda x: checkPop(x, current_word))
#     if not pop:
#         return 0
#     return int(pop)


def getPop(current_word):
    for row in popRDD:
        line = row.split(',')
        if current_word == line[1] or current_word == line[2]:
            pop = row.split(',')[-1].strip('\n')
            if not pop:
                return 0
            return int(pop)
    return 0

def mapfn(record):
    line = record.split(',')
    location = line[1]
    return (location, int(line[2]))

res = mainRDD.map(lambda record: mapfn(record)).reduceByKey(lambda a,b:a+b).map(lambda x: modify(x[0], x[1])).filter(bool)
res.collect()
res.saveAsTextFile('hdfs://localhost:9000' + outputpath)