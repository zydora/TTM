function X = ModePro(T,A,k)
% T is the given Tensor, should be multiplicated by A from k-mode
dim = size(T);
if k > length(dim)
    fprintf('Input dimension index exceeds dimension of Tensor');
elseif (size(A,1)~=dim(k))||(size(A,2)~=dim(k))
    fprintf('Dimensions of Matrix are wrong');
end
if size(A,2)~=dim(k)
    A = A';
end
X = Unfold(T,k);
X = A*X;
dim(k) = [size(A,1)];
X = reshape(X,dim);
end