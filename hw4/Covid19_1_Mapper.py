# """Covid19_1_Mapper.py"""
import sys
args = sys.argv
includeWorld = args[1] or 'True'

# with open(inputPath) as f:
#     next(f)
firstline = True
for line in sys.stdin:
    if firstline:    #skip first line
        firstline = False
        continue
    line = line.split(',')
    givenDate = line[0].split('-') # 1/27/2020
    givenDate = list(map(int, givenDate))
    if givenDate[0] == 2019:
        continue
    location = line[1]
    
    if location == 'World' and includeWorld == 'True':
        pass
    elif location == 'World':
        continue
    print('%s\t%s' % (location, int(line[2])))

