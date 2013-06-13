
pat =
    r"^[^\t]*\t  (?# seqname )
       [^\t]*\t  (?# source )
       [^\t]*\t  (?# feature )
       \d+\t     (?# start )
       \d+\t     (?# end )
       (\.|[+\-]? (' '* \d+ (\. \d*)? | \. \d+) ([eE] [+\-]? \d+)?)\t (?# score)
       [+\-\.]\t (?# strand )
       [012\.]\t (?# frame)
       (\ * [A-Za-z][A-Za-z0-9_]* \ +
          (\"\" | \" [^\"\n\r\t]* [^\\] \" | [^\"\s]*) \ * ;)*
       (' '* [A-Za-z][A-Za-z0-9_]* ' '+
          (\"\" | \" [^\"\n\r\t]* [^\\] \" | [^\"\s]*) \ *)?$"xm

data = readall(open("sample.gtf"))

@time begin
    count = 0
    for mat in eachmatch(pat, data)
        count += 1
        if count % 100 == 0
            println(count)
        end
    end
    println(count)
end



