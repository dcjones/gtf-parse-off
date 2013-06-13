#!/usr/bin/env python

import re

patstr = \
    r"""^[^\t]*\t  (?# seqname )
       [^\t]*\t  (?# source )
       [^\t]*\t  (?# feature )
       \d+\t     (?# start )
       \d+\t     (?# end )
       (\.|[+\-]? (' '* \d+ (\. \d*)? | \. \d+) ([eE] [+\-]? \d+)?)\t (?# score)
       [+\-\.]\t (?# strand )
       [012\.]\t (?# frame)
       (\ * [A-Za-z][A-Za-z0-9_]* \ +
          (\"\" | \" [^\"\n\r\t]* [^\\] \" | [^\"\s]*) \ * ;)*
       (\ * [A-Za-z][A-Za-z0-9_]* \ +
          (\"\" | \" [^\"\n\r\t]* [^\\] \" | [^\"\s]*) \ *)?$"""

pat = re.compile(patstr, re.X | re.MULTILINE)

data = open("sample.gtf").read()

count = 0
for mat in pat.finditer(data):
    count += 1

print(count)

#mat = pat.match(data)
#assert mat
#print(mat.start())
#print(mat.end())


#print(data[mat.start():mat.end()])
