function x = npe(x,k)
%% knn
m = size(x,2);%
A = zeros(m,m);
for i = 1:m
    for j = 1:m
        A(i,j) = norm(x(i)-x(j));
    end
end
q = 1:m;
q = q';
for i = 1:m
    [~,index] = sort(A(i,:),'descend');
    index = index';
    index = [index q];
    [M,~] = sortrows(index,1);
    B(i,:) = M(:,2);
end
C = zeros(m,m);
C(find(B<6))=1;
%% 
