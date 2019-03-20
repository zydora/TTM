function G = TerTTSVDMiddle(A,eplison,r,bt)
% bt should be [dim-1] dimension vector of 1/2
dim = size(A);n = dim;middle = ceil(length(n)/2);
delta = eplison*norm(reshape(A,[size(A,1),prod(size(A))/size(A,1)]),'fro')/sqrt(length(n)-1);
C = A; 
tr = zeros(1, length(n)+1);
if r(1) ~= 1 && r(end)~=1
    fprintf('r(1)and r(end) should be 1\n');
    return;
end
tr(1) = 1;tr(end) = 1;
%% 
for k = 1:length(n)-1
    C = reshape(C,[prod(n(1:k)), prod(size(C))/prod(n(1:k))]);tr(k+1) = rank(C)
    if r(k+1)> tr(k+1)
        fprintf('Input rank should be less than rank of tensor\n');
        return
    end
end
%%
C = reshape(C,[prod(n(1:middle)), prod(size(C))/prod(n(1:middle))]);tr(middle+1) = rank(C);
if bt(middle) == 2
        [M,a,R] = TerDecom(C,r(middle+1));
    elseif bt(k) == 1
        [M,a,R] = BiDecom(C,r(middle+1));
end
    C_right = a;
    C_left = M;
    C = C_right;
    fprintf('right sweep\n');
for k = middle+1:length(n)-1
    fprintf('core %d updating\n',k);
    C = reshape(C,[tr(k)*n(k), prod(size(C))/(tr(k)*n(k))]);tr(k+1) = rank(C);
    
    if bt(k) == 2
        [M,a,R] = TerDecom(C,r(k+1));
    elseif bt(k) == 1
        [M,a,R] = BiDecom(C,r(k+1));
    end
    error = norm(R,'fro');fprintf('error is %f\n',error);
    G{k} = reshape(M(:,1:r(k+1)),[r(k),dim(k),r(k+1)]);
    C = pinv(M)*C;
    tr(k+1) = r(k+1);
end
G{length(dim)} = C(1:rank(C),1:n(length(dim)));
G{length(dim)} = reshape(G{length(dim)},[size(G{length(dim)}),1]);
C = C_left';
fprintf('left sweep\n');
for k = middle:-1:2
    fprintf('core %d updating\n',k);
    C = reshape(C,[tr(k+1)*n(k), prod(size(C))/(tr(k+1)*n(k))]);tr(k) = rank(C);
    
    if bt(k) == 2
        [M,a,R] = TerDecom(C,r(k));
    elseif bt(k) == 1
        [M,a,R] = BiDecom(C,r(k));
    end
    error = norm(R,'fro');fprintf('error is %f\n',error);
    G{k} = reshape(M(:,1:r(k)),[r(k+1),dim(k),r(k)]);
    G{k} = permute(G{k},[3,2,1]);
    C = pinv(M)*C;
    tr(k) = r(k);
end
G{1} = permute(C(1:rank(C),1:n(1)),[3,2,1]);
%tr(length(dim)+1) = 1;

end