clear;

rng(12, 'twister');

%read in data
A = readmatrix('winequality.csv');

%split into inputs and outputs
%X = [A(:,1:11), A(:,1:11).^2];
X = A(:,1:11);
y = A(:,12);

%train and test split
p = randsample(1599,1200);
q = setdiff(1:1599,p);
X_train = X(p,:);
X_test = X(q,:);
y_train = y(p,1);
y_test = y(q,1);

%train linear regression model
mdl1 = fitlm(X_train,y_train);
mdltree = TreeBagger(20, X, y, 'Method', 'regression', 'MinLeafSize', 10);

%predict on test set
ypred1 = predict(mdltree,X_test);

%compute rmse
rmse1 = rms(round(ypred1)-y_test);

disp(rmse1)
