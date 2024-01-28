import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit

#double exponential function fitting
def double_exp(x, b, c, p, q):
  x = np.array(x)
  return b*np.exp(p*x) + c*np.exp(q*x)


xx=pd.read_csv('t_t.csv',header=None)
xx=np.array(xx)
xx=np.ravel(xx)
xx=list(xx)
yy=pd.read_csv('k_9c_10.csv',header=None)
yy=np.array(yy)
yy=list(yy)
y1=np.ravel(yy)
y1=list(y1)
plt.scatter(xx, y1)
plt.show()


popt1, pcov1 = curve_fit(double_exp, xx, y1,maxfev=500000)

print(popt1)


b = popt1[0]
c = popt1[1]
p = popt1[2]
q = popt1[3]

y_fit = double_exp(xx,b,c,p, q)

plt.scatter(xx, y1)
plt.plot(xx, y_fit, color='red', linewidth=1.0)

plt.show()
#Calculate R^2
mean = np.mean(y1)  # 1.y mean
ss_tot = np.sum((y1 - mean) ** 2)  # 2.total sum of squares
ss_res = np.sum((y1 - double_exp(xx, *popt1)) ** 2)  # 3.residual sum of squares
r_squared = 1 - (ss_res / ss_tot)  # 4.r squared
r_squared

#single exponential function fitting
def single_exp(x,a,d):
  x = np.array(x)
  return a*np.exp(d*x)

popt2, pcov2 = curve_fit(single_exp, xx, y1,maxfev=500000)

print(popt2)

a = popt2[0]
d = popt2[1]

y_fit2 = single_exp(xx,a, d)

plt.scatter(xx, y1)
plt.plot(xx, y_fit2, color='red', linewidth=1.0)

plt.show()


mean = np.mean(y1)  # 1.y mean
ss_tot = np.sum((y1 - mean) ** 2)  # 2.total sum of squares
ss_res = np.sum((y1 - single_exp(xx, *popt2)) ** 2)  # 3.residual sum of squares
r_squared = 1 - (ss_res / ss_tot)  # 4.r squared
r_squared

