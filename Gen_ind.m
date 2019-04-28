function X = Gen_ind(x,r)
% x should be vector [ 1 2 3 4 5 6]
% r should be rank < size(x,2)
x = x';n = length(x);
X = zeros(length(x)^r,r);
for i = 1:r
    tempX = repmat(x',[n^(i-1),1]);
    tempX = tempX(:);
    tempX = repmat(tempX,[n^(r-i),1]);
    X(:,r-i+1) = tempX;
end
end