%%
% If you want to verify

A = randn(2,2);
x = randn(5,5);
X = reshape(x',[prod(size(x)),1]);
AA = Convert_toeplitz(A,x);
result = AA*X;
[mA, nA] = size(A);
[mX,nX] = size(x);
for i = 1:mX-mA+1
    for j = 1:nX-nA+1
        M(i,j) = sum(sum(reshape(fliplr(reshape(A,[1,mA*nA])),[mA,nA]).*x(i:i+mA-1,j:j+nA-1)));
    end
end
reshape(result,[mX-mA+1,nX-nA+1])'-M