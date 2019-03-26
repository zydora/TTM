% Inference only
W = net_fc.layers;
for i = 1:4
    WW{i} = W{2*i-1}.weights{1};
    bias{i} = W{2*i-1}.weights{2};
end
fprintf('conv-pool-conv-pool-fc-relu-fc-softmax')
%% inference back
load('C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\data\mnist-baseline\imdb.mat')
M = images.data;
M1 = conv(M,WW{1});
M2 = maxpool(M1);
M3 = conv(M2,WW{2});
M4 = maxpool(M3);
M5 = conv(M4,WW{3});
M6 = relu(M5);
M7 = conv(M6,WW{4});
M8 = softmax(M7);

%% layer
