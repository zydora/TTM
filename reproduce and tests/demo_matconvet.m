%% Parameter
kw = 640; kw = 320; kw = 128;
kx = [1,2,3,4];
%% change the Weights and bias
[M,~] = cnn_mnist;
M1 = M.layers{5}.weights;
M2 = M.layers{7}.weights;
% [W1,error,ee] = Reconstruct(M1{1},[8,8,8,8,10,16],[1,8,64,100,100,16,1])
% [W2,error,ee] = Reconstruct(M2{1},[2,2,4,5,8,10],[1,2,4,16,80,10,1])
bits = 1;
%% 
for i = 1:8
    if bits == i
        load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test1\test',num2str(i),'.mat']);
        %load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test2\test',num2str(i),'.mat']);
    end
end
M.layers{5}.weights = reshape(permute(reshape(ProTTSVD(G),[640,1024]),[2,1]),size(tmp_net.Layers(6).Weights));
% for i = 1:8
%     if bits == i
%         %load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test1\test',num2str(i),'.mat']);
%         load(['C:\Users\eee\Documents\MATLAB\Toolbox\matconvnet-1.0-beta25\matconvnet-1.0-beta25\examples\mnist\test2\test',num2str(i),'.mat']);
%     end
% end
%%
% activations
%[Mb,c,b]=TerDecomLarge(TrainImages,4) 
%% reload data
%clear all;clc
Dataset = 'MNIST';%You should change the W number nodes as same.
[TrainImages,TestImages,TrainLabels,TestLabels] = load_dataset(Dataset);
% QQ = TrainImages(:,10000);
% q = randperm(50000);
% q = mod(q,784)+1;
% q = reshape(q,[5,10000]);
for i = 1:10000
rsc = vl_simplenn(M, TrainImages(:,i));
end