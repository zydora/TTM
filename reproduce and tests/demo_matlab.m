%% matlab own function (not applicable)
clear;clc;
%% Parameter
kw = 640; kw = 320; kw = 128;
kx = [1,2,3,4];

%% matlab own function
if true
% Loading Data and Splitting them to the Training and Testing Data Set
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos',...
'nndatasets','DigitDataset');
digitData = imageDatastore(digitDatasetPath,...
'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = 1000;
rng(1) % For reproducibility
[trainDigitData,testDigitData] = splitEachLabel(digitData,...
trainingNumFiles,'randomize');
% Defining Layers
layers = [imageInputLayer([28 28 1]);
convolution2dLayer(5,20);
maxPooling2dLayer(2,'Stride',2);
convolution2dLayer(5,64);
maxPooling2dLayer(2,'Stride',2);
convolution2dLayer(4,640);
reluLayer();
fullyConnectedLayer(10);
softmaxLayer();
classificationLayer()];
% Training the convnet
options = trainingOptions('sgdm','MaxEpochs',20,...
'InitialLearnRate',0.0001);
convnet = trainNetwork(trainDigitData,layers,options);
end
%% change the Weights and bias
M = convnet;
%%
%[W1,error,ee] = Reconstruct(convnet.Layers(6).Weights,[8,8,8,8,10,16],[1,8,64,100,100,16,1],1)
[W1,error,ee] = Reconstruct(convnet.Layers(6).Weights,[20,32,32,32],[1,20,600,32,1],4)
%[W1,a,R] = TerDecomMultibits(reshape(convnet.Layers(6).Weights,[1024,640]),320,1)

bits = 1;





%% 
tmp_net = convnet.saveobj;
tmp_net.Layers(2).Weights = reshape(M.Layers(2).Weights,size(tmp_net.Layers(2).Weights));
tmp_net.Layers(2).Bias = reshape(M.Layers(2).Bias,size(tmp_net.Layers(2).Bias));
tmp_net.Layers(4).Weights = reshape(M.Layers(4).Weights,size(tmp_net.Layers(4).Weights));
tmp_net.Layers(4).Bias = reshape(M.Layers(4).Bias,size(tmp_net.Layers(4).Bias));
% for i = 1:8
%     if bits == i
%         load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test1\test',num2str(i),'.mat']);
%         %load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test2\test',num2str(i),'.mat']);
%     end
% end

tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
tmp_net.Layers(6).Bias = reshape(M.Layers(6).Bias,size(tmp_net.Layers(6).Bias));
% for i = 1:8
%     if bits == i
%         %load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test1\test',num2str(i),'.mat']);
%         load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test2\test',num2str(i),'.mat']);
%     end
% end
tmp_net.Layers(8).Weights = reshape(M.Layers(8).Weights,size(tmp_net.Layers(8).Weights));
tmp_net.Layers(8).Bias = reshape(M.Layers(8).Bias,size(tmp_net.Layers(8).Bias));
%%
% activations
%[Mb,c,b]=TerDecomLarge(TrainImages,4) 
%% reload data
%clear all;clc
% Dataset = 'MNIST';%You should change the W number nodes as same.
% [TrainImages,TestImages,TrainLabels,TestLabels] = load_dataset(Dataset);
% QQ = TrainImages(:,10000);
% q = randperm(50000);
% q = mod(q,784)+1;
% q = reshape(q,[5,10000]);

%%
%tmp_net.Layers(8).Bias = reshape(M.layers{7}.weights{2},size(tmp_net.Layers(8).Bias));
convnet = convnet.loadobj(tmp_net);
Y = classify(convnet, trainDigitData);
YLabels = trainDigitData.Labels;