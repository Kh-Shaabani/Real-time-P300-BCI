function [ y,S ] = mySTDA_test1( X,W1_op,W2_op,w )
%Spatial-Temporal Discriminant Analysis Classifier for two classes of P300
%   X:matrix of test data,size(X)=[D1,D2,I]=[spatial features,temporal features,samples].
%   W1_op:optimal W1(W in spatial space)(D1*L).
%   W2_op:optimal W2(W in temporal space)(D2*L).
%   w:projection vector(L^2*1).
%   y:labeles of X, size(y)=[1,1].
%   S:scores of I samples of X, size(S)=[1,I].


for i=1:size(X,3)
    A=(W1_op'*X(:,:,i))*W2_op;      % size(A)=[L,L]
    F(:,i)=A(:);                % size(F)=[L^2,I]
end
[ y,S ] = myLDA_test1( F,w );

end

