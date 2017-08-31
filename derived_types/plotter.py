import sys, os, glob
import logging
import numpy as np 
import pylab as plt

filename= 'gaussian2d.txt'
if not os.path.exists(filename):
  logger.error('Input file {0} does not exist'.format(filename))
  sys.exit(1)

data = np.loadtxt(filename)
print type(data), len(data), data.shape

fig, ax = plt.subplots(1, figsize=(6,6), projection='3d')



