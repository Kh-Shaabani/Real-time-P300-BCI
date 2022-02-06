function [ y,S ] = myLDA_test1( X,w )        % myLDA_test
%Linear Discriminant Analysis Classifier for two classes
%   X:matrix of test data,size(X)=[D,I]=[features,buttons].
%   w:projection vector(D*1).
%   y:labeles of X, size(y)=[1,1].
%   S:scores of I samples of X, size(S)=[1,I].


S=w'*X;             % classification score, size(S)=[1,I]
[s,y]=max(S);       % score and label of target, size(y)=[1,1]

end