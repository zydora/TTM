%%
%Write a Matlab function that efficiently computes the outer product of any given number of arbitrary vectors.
function V_pro = OutPro(V)
% V is the tuple of given vectors
[num1 num2] = size(V);
num = max(num1,num2);% number of vectors
V_pro = V{1};V_dim = max(size(V{1}));
for i = 2:num
    tempV  =V_pro(:);
    if size(V{i},1)>size(V{i},2)
        V{i} = V{i}';
    end
    tempV = tempV*V{i};
    V_dim = [V_dim max(size(V{i}))];
    V_pro = reshape(tempV,V_dim);
end
end
    

