#!/usr/bin/python -tO
# -*- coding: utf-8 -*-

# -O compiles to PYC files which are faster
# -t gives you whitespace warnings
# if this happens to select-all in emacs and "reindent"

# -t -t issues an error 

import os
import sys
import re
#from basic_tools import *

from operator import itemgetter


if len( sys.argv ) != 3:
    print "\n\tUSAGE: get-breakpoint-free-regions.py    3s.rec.csv   alignment_length\n"
    sys.exit(-1)


infile1  = open( sys.argv[1], 'r' )
strHeader = infile1.readline()	# this is the header line 

alignment_length = int( sys.argv[2] )

lst_all_breakpoints = []

s = infile1.readline()
while len(s) > 0:
    l = s.split(',')

    for i in range(12,len(l)):
        bppair = l[i].split('&')
        if len(bppair)==2:
            range_ends_1 = bppair[0].split('-')
            range_ends_2 = bppair[1].split('-')
            bp1 = int( ( int(range_ends_1[0]) + int(range_ends_1[1]) )/ 2.0 )
            bp2 = int( ( int(range_ends_2[0]) + int(range_ends_2[1]) ) / 2.0 )
            lst_all_breakpoints.append(bp1)
            lst_all_breakpoints.append(bp2)
            #print bp1, bp2
        #print bppair



    s = infile1.readline()


infile1.close()

# print lst_all_breakpoints
# print 
# print len( lst_all_breakpoints )
# print 
# print set( lst_all_breakpoints )
# print

lst_sorted_breakpoints = sorted( list( set ( lst_all_breakpoints) ) )

# print lst_sorted_breakpoints
# print
# print len( lst_sorted_breakpoints )
# print

LL = []

lst_first_triple = [1, lst_sorted_breakpoints[0], 0]

LL.append( lst_first_triple )

# print LL

for i in range( len( lst_sorted_breakpoints)-1 ):

    this_triple = [ lst_sorted_breakpoints[i], lst_sorted_breakpoints[i+1], 0]
    LL.append( this_triple )

LL.append( [ lst_sorted_breakpoints[ len(lst_sorted_breakpoints)-1 ], alignment_length , 0] )

#print LL
#print

for l in LL:
    l[2] = l[1] - l[0]


LL_sorted = sorted(LL, key=itemgetter(2), reverse=True)

for l in LL_sorted:
    print l[0], ", ", l[1], ", ", l[2]









