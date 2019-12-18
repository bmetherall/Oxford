clear;

rng(12, 'twister');

%read in data
A = readmatrix('diabetes.csv');

%split into inputs and outputs
%X = [A(:,1:11), A(:,1:11).^2];
X = A(:,1:end-1);
y = A(:,end);

%train and test split
p = randsample(768,768*3/4);
q = setdiff(1:768,p);
X_train = X(p,:);
X_test = X(q,:);
y_train = y(p,1);
y_test = y(q,1);

%train linear regression model
%mdl1 = fitlm(X_train,y_train);
%mdltree = TreeBagger(20, X, y, 'Method', 'regression', 'MinLeafSize', 10);
mdl = fitcknn(X_train, y_train, 'NumNeighbors', 3, 'Standardize', 1);

%predict on test set
ypred1 = predict(mdl,X_test);

%compute rmse
rmse1 = 1 - sum(abs(ypred1-y_test)) / length(y_test);

disp(rmse1)