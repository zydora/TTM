% demo
%% para (MPO)
d = 6;
% index_i = [2,3,3,5,7,7];
% index_j = [2,2,3,3,7,11];
index_i = [2,2,2,3,3,3];
index_j = [2,2,3,3,3,4];
d = length(index_i);

A = randn(prod(index_i), prod(index_j));

A =  reshape(A,[index_i,index_j]);
n = zeros(d*2,1);label = 1:2*d;
for i = 1:d
    index((i-1)*2+1) = label(i);
    index(2*i) = label(d+i);
    n((i-1)*2+1) = index_i(i);
    n(i*2) = index_j(i);
end
A = permute(A,index);
for i = 1:d
    nn(i) = n((i-1)*2+1)*n(2*i);
end
AA = reshape(A,nn);

%% Algo.
% A = AA;
% bt = 2*ones(length(size(A))-1,1);
% G = TerTTSVD(A,0.01,[1,4,6,9,15,8,8,1],bt)
% M = ProTTSVD(G);
% tensornorm(M-A)
%% Algo.
A = AA;
bt = 2*ones(length(size(A))-1,1)';
G = MPODecom(A,0.01,[1,4,6,9,8,6,1],bt);
M = ProTTSVD(G);
tensornorm(M-A)