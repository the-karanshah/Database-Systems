# """Covid19_1_Reducer.py"""

from operator import itemgetter
import sys

args = sys.argv 
csvPath = 'populations.csv'

current_word = None
current_count = 0
word = None

def getPop(current_word):
    with open(csvPath, 'r') as fp:
        next(fp)
        for row in fp:
            line = row.split(',')
            if current_word == line[1] or current_word == line[2]:
                pop = row.split(',')[-1].strip('\n')
                if not pop:
                    return 0
                return int(pop)
    return 0

for line in sys.stdin:
    line = line.strip()
    word, count = line.split('\t', 1)

    try:
        count = int(count)
    except ValueError:
        continue

    if current_word == word:
        current_count += count
    else:
        if current_word:
            pop = getPop(current_word)
            if pop:
                current_count2 = (current_count / pop) * 1000000
                sys.stdout.write('%s\t%s\n' % (current_word, current_count2))
        current_count = count
        current_word = word

if current_word == word:
    pop = getPop(current_word)
    if pop:
        current_count2 = (current_count / pop) * 1000000
    sys.stdout.write('%s\t%s\t' % (current_word, current_count2))