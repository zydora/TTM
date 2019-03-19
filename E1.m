% exercise 1
dim = [4,2,3];
for i = 1:3
    V{i} = randn(dim(i),1)';
end
Pro1 = OutPro(V);
tV = V;
clear V
V{1} = tV{2};
V{2} = tV{1};
V{3} = tV{3};
Pro2 = OutPro(V);
fprintf('The error between two products:')
Pro1 
size(Pro1)
Pro2
size(Pro2)
fprintf('Now reshape the V to let them equal')
Pro2 = permute(Pro2,[2,1,3]);
size(Pro2)