function G = MPODecom(A,eplison,r,bt)
% Input: A: reshaped matrix [ 1200, 1, 1, 1, 1, 600]
%        eplison: error bound
%        r: rank of TTcores
%% preprocession
% This case considers matrix case temporarily
% For tensor case, should sort first, and turn it back in According part
flip = 0;
dim = size(A);n = dim;
if n(1)>n(end)
    m = fliplr(1:length(n));
    A = permute(A,m);
    flip = 1;
    n = fliplr(n);
end
%%
delta = eplison*norm(reshape(A,[size(A,1),prod(size(A))/size(A,1)]),'fro')/sqrt(length(n)-1);
C = A;
tr = zeros(1, length(n)+1);
if r(1) ~= 1 && r(end)~=1
    fprintf('r(1)and r(end) should be 1\n');
    return;
end
tr(1) = 1;tr(end) = 1;
%% Decom part
% Problem is, svd algorithm guarantees reconstruction in a errorless way,
% when sign(U), problems generate
for k = 1:length(n)-1
    C = reshape(C,[tr(k)*n(k), prod(size(C))/(tr(k)*n(k))]);tr(k+1) = rank(C);
    if r(k+1)> tr(k+1)
        fprintf('Input rank should be less than rank of tensor\n');
        return
    elseif r(k+1)<tr(k+1)
        fprintf('truncate by r input\n');
    end
    [U{k},S{k},V{k}] = svd(C);
    if bt(k) == 1% binary
        tU = sign((U*1));
    elseif bt(k) == 2
        tU = sign(round(U{k}*size(U{k},2)/(2*sum(abs(U{k}(1,:))))));% when matrix is larger, svd decomposition makes its value smaller
    end
    tC = pinv(tU)*C;
    E = C - tU*(pinv(tU)*C);
    
    C = tC(1:r(k+1),:);
    error = norm(E,'fro'); fprintf('svd error norm %f\n',error);
    G{k} = reshape(tU(:,1:r(k+1)),[r(k),n(k),r(k+1)]);
    tr(k+1) = r(k+1);
end
%tr(length(dim)+1) = 1;
G{length(dim)} = C(1:rank(C),1:n(length(dim)));
G{length(dim)} = reshape(G{length(dim)},[size(G{length(dim)}),1]);

%% According to preprocession
if flip == 1
    for i = 1:length(n)
        if i == 1
            tG{i} = permute(G{length(n)},[2,1]);
            tG{i} = reshape(tG{i},[1,size(tG{i})]);
        end
        tG{i} = permute(G{length(n)+1-i},[3,2,1]);
    end
    G = tG;
end
end