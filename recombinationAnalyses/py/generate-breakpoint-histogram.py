#!/usr/bin/python -tO
# -*- coding: utf-8 -*-

# -O compiles to PYC files which are faster
# -t gives you whitespace warnings
# if this happens to select-all in emacs and "reindent"

# -t -t issues an error 

import os
import sys
import re
import numpy

#from basic_tools import *

SEQLEN = 31000
#SEQLEN = 500

X = numpy.zeros(SEQLEN+1)

#
# give the function a list below that looks like: ['5-7 & 20-33', '5-7 & 40-45', .. ]
#
def is_bp_inside_range_list( loc, bp_range_list ):
    
    for rngpair in bp_range_list:

        if len( rngpair.strip() ) == 0: # this means the range-pair is blank
            continue
        
        ranges = rngpair.split('&')
        #print ranges
        bnds0 = ranges[0].split('-')
        bnds1 = ranges[1].split('-')

        if loc >= int(bnds0[0]) and loc <= int(bnds0[1]):
            return True
        if loc >= int(bnds1[0]) and loc <= int(bnds1[1]):
            return True
        
    return False
    

if len( sys.argv ) != 2:
    print "\n\tUSAGE: generate-breakpoint-histogram.py  3s.rec.csv  \n"
    sys.exit(-1)



# read in the higher dilutions file
infile1  = open( sys.argv[1], 'r' )
strHeader = infile1.readline()	# this is the header line 
i=1

s = infile1.readline()
while len(s) > 0:
    l = s.split(',')
    lbp = l[12:]

    #print lbp
    #for e in range(len(l)):
        #print "\n\t", e, "\t", l[e]
        #i = i + 1
        
    for j in range(SEQLEN+1):
        b = is_bp_inside_range_list( j, lbp )
        if b:
            X[j] = X[j] + 1
    
    print "\tbp line ", i  

    i = i + 1
    s = infile1.readline()

infile1.close()



f = open('new.bp.histogram.csv', 'w')
f.write( "POS,NUM_SUPPORTING_SEQUENCES\n" )    

for j in range(SEQLEN+1):
    f.write( `j` + " , " + `X[j]` + "\n" )    

f.close()