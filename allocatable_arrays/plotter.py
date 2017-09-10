import sys, os, glob
import logging
import numpy as np 
import pylab as plt

filename= 'gaussian2d.txt'
if not os.path.exists(filename):
  logger.error('Input file {0} does not exist'.format(filename))
  sys.exit(1)

dtype = [('x', float), ('y', float), ('z', float)]
data  = np.loadtxt(filename, dtype=dtype)
x1d   = np.unique(data['x'])
y1d   = np.unique(data['y'])
z1d   = data['z']

x2d, y2d = np.meshgrid(x1d, y1d)

print x1d.shape, y1d.shape, x2d.shape, y2d.shape
print x1d
z2d   = np.reshape(z1d, x2d.shape)

# Plot a contour of z
fig, ax = plt.subplots(1, figsize=(5, 5))
ax.contour(x2d, y2d, z2d)

plot_name = 'gaussian2d.png'
plt.savefig(plot_name, transparent=True)
print '{0} saved'.format(plot_name)
plt.close()




