 %% demo TTMSVD
% decompose a matrix
A = randn(1200,600)';
A = reshape(A,[size(A,1),1,1,1,1,size(A,2)]);
bt = ones(length(size(A))-1,1);
G = TerTTSVD(A,0.01,[1,600,600,600,600,600,1],bt)
M = ProTTSVD(G);
M-A
% it works!

%% demo
% input is a binary tensor
C = demoC*10;
A = C;
bt = 2*ones(length(size(A)),1);
G = TerTTSVD(A,0.001,[1,4,4,4,1],bt)
M = ProTTSVD(G);
M-A
% it works!
%%
A = randn(4,6,8,8,10);
bt = 2*ones(length(size(A)),1);
G = TerTTSVD(A,0.001,[1,4,6,8,8,10,1],bt)
M = ProTTSVD(G);
M-A
%% test Algo.2
x = randn(20,1);
[M,c,b] = TerDecomW(x,10);
error  =norm(x-M*c-b)
% problems

%% test MPODecom
A = randn(648,144);
A = reshape(A,[size(A,1),1,1,1,1,size(A,2)]);
bt = 2*ones(length(size(A))-1,1)';
G = MPODecom(A,0.01,[1,144,144,144,144,144,1],bt);
M = ProTTSVD(G);
tensornorm(M-A)
% it works!