# """Covid19_1_Mapper.py"""
import sys

# with open(inputPath) as f:
#     next(f)
firstline = True
for line in sys.stdin:
    if firstline:    #skip first line
        firstline = False
        continue
    line = line.split(',')
    location = line[1]

    print('%s\t%s' % (location, int(line[2])))

