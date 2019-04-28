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
%% 1

% for i = 1:3
% for bits = 1:8
%     [W1,error,ee,G] = Reconstruct(M.Layers(6).Weights,[640,1024],[1,320,1],bits);
%     tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
%     convnet = convnet.loadobj(tmp_net);
%     Y = classify(convnet, trainDigitData);
%     YLabels = trainDigitData.Labels;
%     acc = sum(Y==YLabels);
%     filename = ['test1_',num2str(i),'_',num2str(bits),'.mat'];
%     save(filename)
%     %save file
% end
% end

%% 2


%% 3
for i = 1:3
for j = 3:4
    bits = j*2;
    [W1,error,ee] = Reconstruct(M.Layers(6).Weights,[8,8,16,20,32],[1,8,64,640,32,1],bits);
    tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
    convnet = convnet.loadobj(tmp_net);
    Y = classify(convnet, trainDigitData);
    YLabels = trainDigitData.Labels;
    acc = sum(Y==YLabels);
    filename = ['test3_',num2str(i),'_',num2str(bits),'.mat'];
    save(filename)
end
end
%% Decomposition
%[W1,error,ee] = Reconstruct(M.Layers(6).Weights,,,bits)
%% 4

%% 5
for i = 1:3
for bits = 6:8
    [W1,error,ee,G] = Reconstruct(M.Layers(6).Weights,[4,4,4,4,4,8,8,10],[1,4,16,64,256,640,80,10,1],bits)
    tmp_net.Layers(6).Weights = reshape(W1,size(tmp_net.Layers(6).Weights));
    convnet = convnet.loadobj(tmp_net);
    Y = classify(convnet, trainDigitData);
    YLabels = trainDigitData.Labels;
    acc = sum(Y==YLabels);
    filename = ['test5_',num2str(i),'_',num2str(bits),'.mat'];
    save(filename)
end
end
