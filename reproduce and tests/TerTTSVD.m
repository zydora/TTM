function [G,e] = TerTTSVD(A,eplison,r,bt,bits)
% bt should be [dim-1] dimension vector of 1/2
dim = size(A);n = dim;e = 0;
delta = eplison*norm(reshape(A,[size(A,1),prod(size(A))/size(A,1)]),'fro')/sqrt(length(n)-1);
C = A; 
tr = zeros(1, length(n)+1);
if r(1) ~= 1 && r(end)~=1
    fprintf('r(1)and r(end) should be 1\n');
    return;
end
tr(1) = 1;tr(end) = 1;
%% 
%iter = 1;
for k = 1:length(n)-1
    C = reshape(C,[tr(k)*n(k), prod(size(C))/(tr(k)*n(k))]);tr(k+1) = rank(C);
    if r(k+1)> tr(k+1)
        fprintf('Input rank should be less than rank of tensor\n');
        break
    end
    if bt(k) == 2
%         qqq = max(size(C,1),size(C,2));qqq = max(qqq,r(k+1));
%         R = 10*randn(5,5);
%         iter = 1;
%         while(1)&&(norm(R)>0.01
        [M,a,R] = TerDecomMultibits(C,r(k+1), bits);
       %iter = iter + 1;
%         end
    elseif bt(k) == 1
        R = 10*randn(5,5);
        iter = 1;
         while(1)&&(norm(R)>0.01)&&(iter < 2)
        [M,a,R] = BiDecomMultibits(C,r(k+1), bits);
        iter = iter + 1;
         end
    end
    error = norm(R,'fro');fprintf('error is %f\n',error);
    e = [e error];
    %save('e',e);
    G{k} = reshape(M(:,1:r(k+1)),[r(k),dim(k),r(k+1)]);
    C = pinv(M)*C;
    C = C(1:r(k+1),:);
    tr(k+1) = r(k+1);
end
%tr(length(dim)+1) = 1;
G{length(dim)} = C(1:rank(C),1:n(length(dim)));
G{length(dim)} = reshape(G{length(dim)},[size(G{length(dim)}),1]);
end