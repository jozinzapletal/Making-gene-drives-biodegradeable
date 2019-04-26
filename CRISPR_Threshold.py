import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure

data1 = pd.read_csv('CRISPR1_1_1%_THRESHOLD_KYROU_gamma0.01_delta0.33.csv',header=None)
lowerBound = -5; # Exponential lower bound used for models
upperBound = -1; # Exponential upper bound used for models


ft = 6
data1 = data1.transpose()
x = np.logspace(lowerBound,upperBound, 250, endpoint=True)
y = np.linspace(0, 0.8, 101)

figure(num=None, figsize=(2.25, 1.83), dpi=300)
ax=plt.subplot(111)

plt.imshow(data1, extent=[10**lowerBound, 10**upperBound, 0, 0.8], origin='lower',cmap='seismic',aspect=.25)

plt.clim(0,1)
cbar = plt.colorbar(ticks=[0,0.2,0.4,0.6,0.8,1], drawedges=False)
cbar.ax.tick_params(labelsize=ft, length=0)
cbar.outline.set_visible(False)
cbar.set_label('Maximum Proportion Transgenic', fontsize=ft)
plt.axis(aspect=100);

plt.ylabel('α',fontsize=ft)
plt.xlabel('Threshold',fontsize=ft)

plt.contourf(x, y, data1, 250, cmap='seismic')

ax.set_xscale('log')
myYtix=[0,0.2,.4,.6,.8]
plt.yticks(myYtix)
plt.tick_params(axis='both', which=u'both', labelsize=ft, length=0)
