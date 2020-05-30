# """Covid19_1_Reducer.py"""

from operator import itemgetter
import sys

current_word = None
current_count = 0
word = None
# input comes from STDIN
# from io import StringIO

# data = u"""\
# China   1
# China   1
# China   1
# China   3
# China   11
# China   9
# China   15
# China   15
# China   25
# China   25
# China   26
# China   38
# China   43
# China   46
# World   1
# World   1
# World   1
# World   3
# World   11
# World   9
# World   15
# World   15
# World   25
# World   25
# World   26
# World   38
# World   43
# World   46
# """

# sys.stdin = StringIO(data)
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
            sys.stdout.write('%s\t%s\n' % (current_word, current_count))
        current_count = count
        current_word = word

if current_word == word:
    sys.stdout.write('%s\t%s\t' % (current_word, current_count))