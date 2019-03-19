function G = TerTTSVD(A,eplison,r,bt)
% bt should be [dim-1] dimension vector of 1/2
dim = size(A);n = dim;
delta = eplison*norm(reshape(A,[size(A,1),prod(size(A))/size(A,1)]),'fro')/sqrt(length(n)-1)
C = A; 
tr = zeros(1, length(n)+1);
if r(1) ~= 1 && r(end)~=1
    fprintf('r(1)and r(end) should be 1');
    return;
end
tr(1) = 1;tr(end) = 1;
%% 
for k = 1:length(n)-1
    C = reshape(C,[tr(k)*n(k), prod(size(C))/(tr(k)*n(k))]);tr(k+1) = rank(C);
    if r(k+1)> tr(k+1)
        fprintf('Input rank should be less than rank of tensor');
        return
    end
    if bt(k) == 2
        [M,a,R] = TerDecom(C,r(k+1));
    elseif bt(k) == 1
        [M,a,R] = BiDecom(C,r(k+1));
    end
    error = norm(R,'fro');
    G{k} = reshape(M(:,1:r(k+1)),[r(k),dim(k),r(k+1)]);
    C = pinv(M)*C;
    tr(k+1) = r(k+1);
end
%tr(length(dim)+1) = 1;
G{length(dim)} = C(1:rank(C),1:n(length(dim)));
G{length(dim)} = reshape(G{length(dim)},[size(G{length(dim)}),1]);
end