#!/usr/bin/python

import os
#returns the names of the files in the directory data as a list

tree = os.walk('/SQL/spool_acco/acco')
#print(tree)

folder = []
allAcco = []
lines = []

for _dir in tree:
    folder.append(_dir)

for address, dirs, files in folder:
    for _file in files:
        allAcco.append(address + '/' + _file)

for acco in allAcco:
    file = open(acco, 'r')
    lines.append(file.readlines())
    file.close()

for i in range(len(lines)):
    ACCO_TERM_CAUSE = str(lines[i]).split(',')[0].split('\'')[1]
    if int(ACCO_TERM_CAUSE) != 0:
        print(int(ACCO_TERM_CAUSE))

print(len(lines))
print(len(allAcco))