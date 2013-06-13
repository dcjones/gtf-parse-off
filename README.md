
## Motivation

These repository contains some rough experimentation in parsing simple file
formats. The main use case I'm evaluating is parsing data in the gene transfer
format (GTF). The format can be parsed by a regular expression, but it's weird
enough that it takes a little work.

GTF is just a stand-in for the sort simple, but not quite trivial file
formats of which there are an abundance of in scientific computing. If we can
build fast parsers for all of these formats with minimal effort, it would help a
lot with Julia's already increasing viability.

## Benchmarks

I timed the parsing of the first *100000 lines* (*24MB*) of Ensembl's version 71
human genome annotations. The full file is *2253155 lines* (*502MB*), so scaling
each of these numbers by about 20 gives the time needed to parse the whole
thing.

These are timings are not terribly scientific. E.g. I'm not counting time
spent on I/O in Julia, but am in the other methods. Also, I may or may not have
been watching youtube videos while I waited for the julia PCRE benchmark to
finish.

| Language | Method            | Elapsed Seconds |
| -------- | ----------------- | --------------: |
| C        | Ragel table-based |            0.42 |
| C        | Ragel goto-based  |            0.05 |
| Python   | Hand written      |           28.28 |
| Python   | Regex             |            0.64 |
| PyPy     | Regex             |            1.09 |
| Ruby     | Ragel table-based |          199.39 |
| Julia    | Ragel table-based |            3.52 |
| Julia    | PCRE              |         1560.50 |

## Notes

My julia backend for ragel at [dcjones/ragel-julia](https://github.com/dcjones/ragel-julia).

The hand-written python parser is from [bcbb](https://github.com/chapmanb/bcbb).


