% test Ter Decom
%% 
clear;clc;
Dataset = 'MNIST';%You should change the W number nodes as same.
[TrainImages,TestImages,TrainLabels,TestLabels] = load_dataset(Dataset);
TrainImages = 1*TrainImages;
TestImages = 1*TestImages;
T = reshape(TrainImages(:,1:60000),[28,28,30,40,50]);
%T2 = reshape(TestImages,[28,28,10,10,100]);
%%
%e = 0;
for i = 1:4
    tic
    r = [1,28,28,28,28,1];
    %[1,7,49,40,20,1]
[G,ee] = TerTTSVD((T),0.01,r,2*ones(6,1),i) % ee is each error
Reconstruct_error = tensornorm(ProTTSVD(G)-T);
toc
%G{i} = A;
filename = ['test',num2str(i),'.mat'];
save(filename)
%e = [ee e]
end
% for i = 1:8
% [A,B,R] = TerDecomMultibits((T2),400,i)
% TG{i} = A;
% e = [e norm(R)]
% end