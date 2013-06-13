#!/usr/bin/env python

# Parsing GTF in python with a hand written parser

from BCBio import GFF

for rec in GFF.parse(open("sample.gtf")):
    pass

