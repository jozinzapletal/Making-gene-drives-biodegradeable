import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from cycler import cycler


generations = 60;
developmentTime = 12;

data1 = pd.read_csv('CRISPR1-5 Progression.csv')
gammaList = [0.01, 0.05, 0.1]
alphaList = [0, 0.1, 0.4, 0.8]


data1.rename(columns={'0': 'gamma', '0.1': 'alpha'}, inplace=True)
ft = 6
xPlot = np.linspace(0,generations+1,generations*developmentTime+1)

for g in gammaList:

    fig1= plt.figure(num=None, figsize=(2.25, 1.83), dpi=300)
    
    for a in alphaList:     
        
        ax = plt.subplot(111)
        
        ind1 = np.array(data1["gamma"]==g)
        ind2 = np.array(data1["alpha"]==a)
    
        yPlot= data1[ind1 * ind2]
        
        yPlot.drop(['alpha','gamma'],axis=1,inplace=True)
        
        colors = ['firebrick', 'red', 'coral', 'lightcoral', 'darkviolet', 'orchid']
        plt.rc('axes', prop_cycle=(cycler('color', colors) + cycler('linestyle', ['-', '-', '-', '-', '-', '-'])))
               
        plt.plot(xPlot,yPlot.T,label=u'α = ' + str(a))
        plt.ylim(0, 1)
        plt.xlim(0,730/12)
        plt.ylabel('Proportion of Wildtype',fontsize=ft)
        plt.xlabel('Time (generations)',fontsize=ft)
        
        ax.spines['right'].set_visible(False)
        ax.spines['top'].set_visible(False)
        ax.yaxis.set_ticks_position('left')
        ax.xaxis.set_ticks_position('bottom')
        
        plt.tick_params(axis='both', which='major', labelsize=ft)
        ax.tick_params(direction="in")
       
        plt.legend(fontsize=ft)
        plt.legend(loc='right', prop={'size':6}, frameon=False, bbox_to_anchor=(1.4,0.7))
        
        plt.text(generations/2.5,1.05, 'γ = ' + str(g), color = 'black', fontsize=ft)
