function temp = ProTTSVD(G)
%% Param
indexG = max(size(G));
for i = 1:indexG
    n(i) = size(G{i},2);
    r(i) = size(G{i},1);
end
r(indexG+1) = size(G{end},length(size(G{end})));

%% product
temp = G{1};dim = size(G{1});
for i = 2:indexG
    temp = reshape(temp,[prod(size(temp))/r(i), r(i)]);
    temp = temp*reshape(G{i},[r(i), prod(size(G{i}))/r(i)]);
    dim = [dim(1:i) n(i) r(i+1)];
    temp = reshape(temp,dim);
end
temp = reshape(temp,dim(2:end-1));
end