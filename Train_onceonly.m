if true
% Loading Data and Splitting them to the Training and Testing Data Set
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos','nndatasets','DigitDataset');
digitData = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = 1000;
rng(1) % For reproducibility
[trainDigitData,testDigitData] = splitEachLabel(digitData,trainingNumFiles,'randomize');
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
M = convnet;
save M