%%% Comparison code with fixed parameters 

%% Initial Setting 
addAllpath; rng('default');

%% Datasets to use 
dataNames={'enron','yeast','medical','CAL500','corel5k','scene','genbase','tmc2007-500'};
numCV=5; numTrial=2; % less than 10


%% Select methods to use
methodNames=cell(2,1);
methodNames{1}={'fRAkEL','LP'};
methodNames{2}={'COCOA','LP'};
%methodNames{3}={'HOMER','LP'};
%methodNames{4}={'CLMLC','LP'};
%methodNames{5}={'CBMLC','LP'};
%methodNames{6}={'fRAkEL','LP'};
%methodNames{7}={'MLCC','LP'};
%methodNames{8}={'TREMLC','LP'};
% methodNames{3}={'RAkEL','LP'};
% methodNames{4}={'fRAkEL','LP'};
% methodNames{5}={'HOMER','LP'};
% methodNames{6}={'CBMLC','LP'};

% functionNames will be used for plot
functionNames={'fRAkEL-LP','COCOA-LP'}; %,'HOMER-LP','CLMLC-LP','CBMLC-LP','fRAkEL-LP','MLCC-LP','TREMLC-LP'};
methodSet=cell(2,1);

for countMethod=1:length(methodNames)
    method.name=methodNames{countMethod};
    method=SetALLParams(method);
    %Common base classifier is considered in this script
    %method.base.name='ridge';
    method.base.name='linear_svm';
    %method.base.param.lambda=10;
    method.base.param.svmparam='-s 2 -q';
    method.th.type='SCut';
    method.th.param=0.4;
    methodSet{countMethod}=method;
    method=[];
end

Result=cell(length(dataNames),1);

for countData=1:length(dataNames)
    dataname=dataNames{countData}
    Result{countData}=cell(length(methodSet),1);
    for countMethod=1:length(methodSet)
        method=methodSet{countMethod};
        [res,conf,pred]=conductExpriments(method,numTrial,numCV,dataname);
        Result{countData}{countMethod}=res;
    end
end    

criteria={'top1','dcg1','auc','exact','hamming','macroF1','microF1'};
% Visualization of results
for i=1:length(criteria)
    criterion=criteria{i};
    getBarPlot(Result,dataNames,functionNames,criterion);
end
