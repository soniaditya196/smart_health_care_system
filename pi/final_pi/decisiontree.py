# Decision Tree Classification

# Importing the libraries
import time
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

from sklearn.preprocessing import MinMaxScaler
from sklearn import linear_model
from sklearn.ensemble import RandomForestRegressor
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error,r2_score
from sklearn.model_selection import KFold
from sklearn import metrics

# Importing the dataset
dataset = pd.read_csv('dataset.csv')
X = dataset.iloc[:, :-1].values
Y = dataset.iloc[:, 8].values
scaler = MinMaxScaler(feature_range=(0, 1))
X = scaler.fit_transform(X)
X.shape,Y.shape



# Fitting Decision Tree Classification to the Training set
from sklearn.tree import DecisionTreeClassifier
classifier = DecisionTreeClassifier(criterion = 'entropy', random_state = 0)

count=0
ans_score = []
time_elapsed = []


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
        model = classifier.fit(X_train,Y_train)
        predictions = classifier.predict(X_test)
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