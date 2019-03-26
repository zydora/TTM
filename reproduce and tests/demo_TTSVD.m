% demo TTSVD

for i = 1:500
    n = [2,4,6,8,10,10,10,10,8,6,4,2];
    A = randn(n);d = length(size(A));
    G = TTSVD(A,0.01,ones(size(n)));
    X = ProTTSVD(G);
    error = norm(reshape(A-X,[size(A,1),prod(size(A))/size(A,1)]));
    fprintf('iter %d, error is %f\n',i,error);
    for j = 1:d
        nn(j) = size(G{j},2);
        if nn(j) ~=n(j)
            fprintf('truncate successful %d\n',j);
        end
    end
end
%% Bug exists!
% in TTSVD, tr(k+1) = rank(C) ,makes problem sometimes (according to n)