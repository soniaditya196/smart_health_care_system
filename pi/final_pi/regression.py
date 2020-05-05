#importing the libraries

import time
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from sklearn import linear_model
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error,r2_score
from sklearn.model_selection import KFold
from sklearn import metrics
#importing the dataset
dataset = pd.read_csv('dataset.csv')
X=dataset.iloc[:, :-1].values
Y=dataset.iloc[:,8].values
X.shape,Y.shape

#fitting multiple linear regression to the training set
from sklearn.linear_model import LinearRegression
regressor = LinearRegression()

count = 0
ans_score = []
time_elapsed = []

#using k-fold cross validation
while count < 100:
    start = time.time()
    kf = KFold(n_splits = 5, shuffle = True)
    
    scores = []
    for i in range(5):
        result = next(kf.split(X), None)
        X_train = X[result[0]]
        X_test = X[result[1]]
        Y_train = Y[result[0]]
        Y_test = Y[result[1]]
        model = regressor.fit(X_train,Y_train)
        predictions = regressor.predict(X_test)
        scores.append(model.score(X_test,Y_test))
    print('Scores from each Iteration: ', scores)
    print('Average K-Fold Score :' , np.mean(scores))

    ans_score.append(np.mean(scores))
    
    
    end = time.time()
    
    print("Time elasped is : ")
    print(end-start)

    time_elapsed.append(end-start)
    count=count+1


print('average score answer = ',np.mean(ans_score))
print('average time elasped = ',np.mean(time_elapsed))