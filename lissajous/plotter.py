
import sys, os, glob, shutil
import logging
import numpy as np 

from mpl_toolkits.mplot3d import Axes3D
import pylab as plt

##########################################################################
def read_file(f):
   if not os.path.exists(f): 
     logger.error('read_file: failed to find file: {0}'.format(f))
     sys.exit(1)
   
   data  = []
   dtype = [('t', np.float32), ('x', np.float32), ('y', np.float32), ('z', np.float32)] 
   with open(f, 'r') as r: lines = r.readlines()
   for i, line in enumerate(lines):
     line = line.rstrip('\r\n').split()
     data.append(line)
   
   rec   = np.core.records.fromarrays(np.array(data).T, dtype=dtype)

   return rec
  
##########################################################################
def plot_lissajous(f):
   if not os.path.exists(f): 
     logger.error('plot_lissjous: failed to find file: {0}'.format(f))
     sys.exit(1)

   rec = read_file(f)
   x   = rec.x
   y   = rec.y
   z   = rec.z

   fig = plt.figure()
   ax  = fig.gca(projection='3d')
   ax.plot(x, y, z)

   png = f.replace('.txt', '.png')
   plt.savefig(png)
   print 'plot_lissajous: saved {0}'.format(png)
   plt.close()
   

##########################################################################
def main():

  files   = glob.glob('data/*.txt')
  n_files = len(files)
  if n_files == 0: return 
  for i, f in enumerate(files):
    plot_lissajous(f)

##########################################################################
if __name__ == '__main__':
  stat = main()
  sys.exit(stat)
