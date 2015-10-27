#!/usr/local/bin/python

#  createSQRT-LUT.py
#  LUTImporter
#
#  Created by Stephan Witoszynskyj on 06.11.13.
#

from math import *
from array import array

filename = "sqrt-lut.dat"

scaleSqrt = sqrt(255)

lut = []

for i in range(0,256):
    lut.append(sqrt(float(i))/scaleSqrt)

f = open(filename,"w")
array('f',lut).tofile(f)
f.close()