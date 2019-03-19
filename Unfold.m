function X = Unfold(T,r)
% T is the r-mode unfolded tensor
dim = size(T);
dim_num = length(dim); r_dim = dim(r);
dim(r)=[];
N = 1:dim_num
N(find(N==r)) = [];
X = permute(T,[r N]);
X = reshape(X,[r_dim prod(dim)]);
end