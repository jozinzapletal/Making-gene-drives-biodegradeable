import pandas as pd
import matplotlib.colors as mcolors
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure


data1 = pd.read_csv('CRISPR1-5 WV Alleles Parameter Space delta0.01 KYROU.csv',header=None)

CONTOURS = [.95, .97]
PLACEMENT = [(0.1,0.2)]

ft = 6 #sets the fontsize throughout the code
x = np.linspace(0, 0.2, 101)
y = np.linspace(0, 0.8, 101)

X, Y = np.meshgrid(x, y)

figure(num=None, figsize=(2.25, 1.83), dpi=300)
ax=plt.subplot(111)


cmap = mcolors.LinearSegmentedColormap.from_list("n", ["blue", "yellow","red"])
plt.imshow(data1, extent=[0, 0.2, 0, 0.8], origin='lower',cmap='seismic',aspect=.25)


plt.clim(0,1)
cbar = plt.colorbar(ticks=[0,0.2,0.4,0.6,0.8,1], drawedges=False)
cbar.ax.tick_params(labelsize=ft, length=0)
cbar.outline.set_visible(False)
cbar.set_label('Proportion Wild-type', fontsize=ft)
plt.axis(aspect=100);

plt.ylabel('α',fontsize=ft)
plt.xlabel('γ',fontsize=ft)

myXtix=[0,0.05,0.1,0.15,.2]
myYtix=[0,.2,.4,.6,.8]

plt.xticks(myXtix)
plt.yticks(myYtix)
plt.tick_params(axis='both', which=u'both', labelsize=ft, length=0)

CS = plt.contour(X, Y, data1, CONTOURS, colors=['white'], linewidths=1.5)

plt.clabel(CS, CONTOURS, fontsize=ft, manual=PLACEMENT, fmt='%4.2f')