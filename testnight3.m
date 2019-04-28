clear acc
load M
digitDatasetPath = fullfile(matlabroot,'toolbox','nnet','nndemos','nndatasets','DigitDataset');
digitData = imageDatastore(digitDatasetPath,'IncludeSubfolders',true,'LabelSource','foldernames');
trainingNumFiles = 1000;
rng(1)
[trainDigitData,testDigitData] = splitEachLabel(digitData,trainingNumFiles,'randomize');
tmp_net = M.saveobj;
tmp_net.Layers(2).Weights = reshape(M.Layers(2).Weights,size(tmp_net.Layers(2).Weights));
tmp_net.Layers(2).Bias = reshape(M.Layers(2).Bias,size(tmp_net.Layers(2).Bias));
tmp_net.Layers(4).Weights = reshape(M.Layers(4).Weights,size(tmp_net.Layers(4).Weights));
tmp_net.Layers(4).Bias = reshape(M.Layers(4).Bias,size(tmp_net.Layers(4).Bias));
tmp_net.Layers(6).Bias = reshape(M.Layers(6).Bias,size(tmp_net.Layers(6).Bias));
tmp_net.Layers(8).Weights = reshape(M.Layers(8).Weights,size(tmp_net.Layers(8).Weights));
tmp_net.Layers(8).Bias = reshape(M.Layers(8).Bias,size(tmp_net.Layers(8).Bias));

%% Decomposition
%[W1,error,ee] = Reconstruct(M.Layers(6).Weights,,,bits)

%% 5
% for i = 1:3
% for bits = 7:8
%     [W1,error,ee] = Reconstruct(M.Layers(6).Weights,[20,32,32,32],[1,20,500,32,1],bits)
%     tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
%     convnet = convnet.loadobj(tmp_net);
%     Y = classify(convnet, trainDigitData);
%     YLabels = trainDigitData.Labels;
%     acc = sum(Y==YLabels);
%     filename = ['test5_',num2str(i),'_',num2str(bits),'.mat'];
%     save(filename)
% end
% end

%% F
for i = 1:3
for bits = 1:8
    [W1,error,ee] = Reconstruct(M.Layers(6).Weights,[20,32,32,32],[1,20,640,32,1],bits)
    tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
    convnet = convnet.loadobj(tmp_net);
    Y = classify(convnet, trainDigitData);
    YLabels = trainDigitData.Labels;
    acc = sum(Y==YLabels);
    filename = ['testF_',num2str(i),'_',num2str(bits),'.mat'];
    save(filename)
end
end
%% 6
for i = 1:3
for bits = 1:8
    [W1,error,ee] = Reconstruct(M.Layers(6).Weights,[20,32,32,32],[1,20,600,32,1],bits)
    tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
    convnet = convnet.loadobj(tmp_net);
    Y = classify(convnet, trainDigitData);
    YLabels = trainDigitData.Labels;
    acc = sum(Y==YLabels);
    filename = ['test6_',num2str(i),'_',num2str(bits),'.mat'];
    save(filename)
end
end