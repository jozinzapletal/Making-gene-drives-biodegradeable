import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from cycler import cycler


generations = 60;
developmentTime = 12;

data1 = pd.read_csv('MEDEA_NR_Alleles.csv')
gammaList = [0.2]
alphaList = [0, 0.1, 0.4, 0.8]
ft = 6

data1.rename(columns={'0': 'gamma', '0.1': 'alpha', '0.2': 'allele'}, inplace=True)
data1.allele[data1.allele == 1] = 'w' 
data1.allele[data1.allele == 2] = 'g' 
data1.allele[data1.allele == 3] = 's'


alleleList = ['w', 'g', 's']

xPlot = np.linspace(0,generations+1,generations*developmentTime+1)

for g in gammaList:
    
    for d in alphaList:
    
        fig1= plt.figure(num=None, figsize=(2.25, 1.83), dpi=300)
        
        for b in alleleList:
        
            ax = plt.subplot(111)
        
            ind1 = np.array(data1["gamma"]==g)
            ind2 = np.array(data1["alpha"]==d)
            ind3 = np.array(data1["allele"]==b)
    
            yPlot= data1[ind1 * ind2 * ind3]
            
            yPlot.drop(['alpha','gamma','allele'],axis=1,inplace=True)         
            
            colors = ['steelblue', 'darkviolet', 'orchid']
            plt.rc('axes', prop_cycle=(cycler('color', colors) + cycler('linestyle', ['-', '-', '-'])))
                                         
            plt.ylim(0, 1)
            plt.xlim(0,generations+1)
            plt.ylabel('Allele Frequency',fontsize=ft)
            plt.xlabel('Time (generations)',fontsize=ft)
        
            ax.spines['right'].set_visible(False)
            ax.spines['top'].set_visible(False)
            ax.yaxis.set_ticks_position('left')
            ax.xaxis.set_ticks_position('bottom')
            
            plt.tick_params(axis='both', which='major', labelsize=ft)
            ax.tick_params(direction="in")
            
            plt.plot(xPlot, yPlot.T, label=b)
            
            plt.legend(fontsize=ft)
            plt.legend(loc='right', prop={'size':6}, frameon=False, bbox_to_anchor=(1.3,0.45))
               
            plt.text(generations/3,1.05, 'α = ' + str(d) + '   γ = ' + str(g), color = 'black', fontsize=ft)
