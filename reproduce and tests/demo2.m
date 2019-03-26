 %% demo TTMSVD
% % decompose a matrix
% A = randn(120,60)';
% A = reshape(A,[size(A,1),1,1,1,1,size(A,2)]);
% bt = ones(length(size(A))-1,1); r = [1 60*ones(1,5) 1];
% G = TerTTSVD(A,0.01,r,bt)
% M = ProTTSVD(G);
% tensornorm(M-A)
% % it works!

%% demo
% input is a binary tensor
% C = demoC*100;
% A = C;
% bt = 2*ones(length(size(A)),1);
% G = TerTTSVD(A,0.001,[1,4,4,4,1],bt)
% M = ProTTSVD(G);
% tensornorm(M-A)
% % Not work!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!%%%%%%%%%%%%%%%%
%%
% A = randn(4,4,4,4,4);
% bt = 2*ones(length(size(A)),1);
% G = TerTTSVD(A,0.001,[1,4,16,16,4,1],bt)
% M = ProTTSVD(G);
% tensornorm(M-A)
% % Not work%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% test Algo.2
% x = randn(20,1);
% [M,c,b] = TerDecomLarge(x,10);
% error  =norm(x-M*c-b)
% % works!

%% test MPODecom
% A = randn(648,144);
% 
% A = reshape(A,[4,4,6,9,9,12]);
% bt = 2*ones(length(size(A))-1,1)';
% rr = ones(1,6)*4;
% r = [1,rr,1];
% G = MPODecom(A,0.01,r,bt);
% M = ProTTSVD(G);
% tensornorm(M-A)
% % it not works for tensor train %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% test MPODecomlarge
% A = randn(648,144);
% A = reshape(A,[size(A,1),1,1,1,1,size(A,2)]);
% A = reshape(A,[4,4,6,9,9,12]);
% bt = 2*ones(length(size(A))-1,1)';
% rr = [4 16 96 108 12];
% r = [1,rr,1];
% G = TerTTSVD(A,0.01,r,bt);
% M = ProTTSVD(G);
% tensornorm(M-A)
%% small
% A = randn(8,27);
% 
% A = reshape(A,[2,2,2,3,3,3]);
% bt = 2*ones(length(size(A))-1,1)';
% rr = [2,4,8,9,3];
% r = [1,rr,1];
% G = TerTTSVD(A,0.01,r,bt);
% M = ProTTSVD(G);
% tensornorm(M-A)
% % not work %%%%%%%%%%%%%%%
%% test Whole code
% x = randn(2,3,6)*10;
% x = reshape(x,[prod(size(x)),1]);
% [M,c,b] = TerDecomLarge(x,8);
% error = norm(M*c+b-x);
% MM = reshape(M,[2,3,6,8]);
% G = MPODecom(MM,0.01,[1,2,6,8,1],2*ones(length(size(x))));
% MMM = ProTTSVD(G);
% tensornorm(MMM-MM)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% test TerTTSVDMiddle
x = randn(4,4,4,4,4,4)*2;

G = TerTTSVDMiddle(x,0.01,[1,4,16,64,16,4,1],2*ones(length(size(x))));
MMM = ProTTSVD(G);
tensornorm(MMM-x)