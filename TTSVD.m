function G = TTSVD(A,eplison,r)
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
    [U,S,V] = svd(C);E = C - U*S*V';
    %% r limit part
    U = U(:,1:r(k+1));S = S(1:r(k+1),:);
    error = norm(E,'fro');tS = S;
    %% truncate part
    for i = size(S,1):-1:1
        temp = 0;
        tS(i,i) = 0;
        tE = C-U*tS*V;
        if norm(tE,'fro') < delta
            S = tS;
            %temp = [temp i];
            r(k+1) = r(k+1)-1;
            fprintf('truncated');fprintf('\n');
        elseif norm(tE,'fro') > delta
            break;
        end
    end
    %%
    G{k} = reshape(U(:,1:r(k+1)),[r(k),dim(k),r(k+1)]);
    C = S*V';
    tr(k+1) = r(k+1);
end
%tr(length(dim)+1) = 1;
G{length(dim)} = C(1:rank(C),1:n(length(dim)));
G{length(dim)} = reshape(G{length(dim)},[size(G{length(dim)}),1]);
end