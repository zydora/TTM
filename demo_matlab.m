%% matlab own function (not applicable)
clear;clc;
%% Parameter and net
bits = 1;
%Train_onceonly;
load M
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos','nndatasets','DigitDataset');
digitData = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = 1000;
rng(1) % For reproducibility
[trainDigitData,testDigitData] = splitEachLabel(digitData,trainingNumFiles,'randomize');

%% Decomposition
[W1,error,ee] = Reconstruct(M.Layers(6).Weights,[8,8,8,8,10,16],[1,8,64,100,100,16,1],bits)
%[W1,error,ee] = Reconstruct(M.Layers(6).Weights,[4,4,4,4,4,8,8,10],[1,4,16,64,100,100,80,10,1],bits)
%[W1,error,ee,G] = Reconstruct(M.Layers(6).Weights,[4,4,4,4,4,4,4,4,10],[1,4,16,64,240,600,160,40,10,1],bits)
%[W1,error,ee] = Reconstruct(M.Layers(6).Weights,[20,32,32,32],[1,20,600,30,1],bits)
%[W1,a,R] = Reconstruct(M.Layers(6).Weights,[640,1024],[1,320,1],1)
%[W1,error,ee,G] = Reconstruct(M.Layers(8).Weights,[10,10,64],[1,10,64,1],8)%%

%% inference
tmp_net = M.saveobj;
tmp_net.Layers(2).Weights = reshape(M.Layers(2).Weights,size(tmp_net.Layers(2).Weights));
tmp_net.Layers(2).Bias = reshape(M.Layers(2).Bias,size(tmp_net.Layers(2).Bias));
tmp_net.Layers(4).Weights = reshape(M.Layers(4).Weights,size(tmp_net.Layers(4).Weights));
tmp_net.Layers(4).Bias = reshape(M.Layers(4).Bias,size(tmp_net.Layers(4).Bias));
tmp_net.Layers(6).Weights = reshape(M.Layers(6).Weights,size(tmp_net.Layers(6).Weights));
tmp_net.Layers(6).Bias = reshape(M.Layers(6).Bias,size(tmp_net.Layers(6).Bias));
tmp_net.Layers(8).Weights = reshape(W1,size(tmp_net.Layers(8).Weights));
tmp_net.Layers(8).Bias = reshape(M.Layers(8).Bias,size(tmp_net.Layers(8).Bias));
convnet = convnet.loadobj(tmp_net);
Y = classify(convnet, trainDigitData);
YLabels = trainDigitData.Labels;

acc = sum(Y==YLabels);