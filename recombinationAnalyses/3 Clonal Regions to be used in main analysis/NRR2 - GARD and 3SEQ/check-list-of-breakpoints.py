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


if len( sys.argv ) != 2:
    print "\n\tUSAGE: check-list-of-breakpoints.py    3s.rec.csv \n"
    sys.exit(-1)


lst_bp_to_check=[1684, 3046, 4448, 9237, 11894, 11885, 14415, 15590, 16466, 20015, 21753, 22773, 22778, 24598, 24628, 24628, 29238]
lst_bp_confirmed=[]

infile1  = open( sys.argv[1], 'r' )
strHeader = infile1.readline()	# this is the header line 

lst_all_breakpoints = []

# tolerance of how close the bp can be
tol=50

counter=1
# go through each line in the 3s.rec.csv file
s = infile1.readline()
while len(s) > 0:
    l = s.split(',')

    #print counter

    for i in range(12,len(l)):
        bppair = l[i].split('&')
        if len(bppair)==2:
            range_ends_1 = bppair[0].split('-')
            range_ends_2 = bppair[1].split('-')
            #print range_ends_1
            #print range_ends_2


            left1  = int(range_ends_1[0])
            right1 = int(range_ends_1[1])
            left2  = int(range_ends_2[0])
            right2 = int(range_ends_2[1])

            for j in range(len(lst_bp_to_check)):
            	if (lst_bp_to_check[j] >= left1-tol and lst_bp_to_check[j] <= right1+tol) or (lst_bp_to_check[j] >= left2-tol and lst_bp_to_check[j] <= right2+tol):
            		if lst_bp_to_check[j] not in lst_bp_confirmed:
            			lst_bp_confirmed.append( lst_bp_to_check[j] )

    counter = counter+1
    s = infile1.readline()


infile1.close()

print lst_bp_confirmed