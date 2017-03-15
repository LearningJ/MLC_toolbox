function[conf]=READER_test(X,Y,Xt,model,method)
%% Input
%X: Feature Matrix (NxF)
%Y: Label   Matrix (NxL)
%Xt:Feature Matrix (NtxF) for test data
%model learned by PCA_train
%% Output
%conf: confidence values (Nt x L);
%linear_svm does not return confidence value since LIBLINEAR does not
%support it.

%% Reference (APA style from google scholar)
%READER: Robust Semi-Supervised Multi-Label Dimension Reduction.

%% Method 
% Get learned model
id = model{2};

%% Feature selection 
tmpX  = X(:,id);
tmpXt = Xt(:,id);

% Testing
[conf] = feval([method.name{2},'_test'],tmpX,Y,tmpXt,model{1},Popmethod(method));