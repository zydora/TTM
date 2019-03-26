% Tucker
function [G,A] = HOSVD(X,r)
dim = size(X);
for n = 1:length(dim)
    [A{n},~,~] = svd(Unfold(X,n));
    A{n} = A{n}(:,1:r(n));
end
tX = X;
for n = 1:length(dim)
    G = ModePro(tX,(A{n})',n);
    tX = G;
end
end
% Uncompleted