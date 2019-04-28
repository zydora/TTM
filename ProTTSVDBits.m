function temp = ProTTSVDBits(G,bits)
%% Param
indexG = max(size(G));
for i = 1:indexG
    n(i) = size(G{i},2);
    r(i) = size(G{i},1);
end
if length(size(G{end}))>2
    r(indexG+1) = size(G{end},3);
elseif length(size(G{end}))==2
    r(indexG+1) = 1;
end

%% product
temp = G{1};dim = size(G{1});
for i = 2:indexG
    temp = round((2^bits-1)*temp)/(2^bits-1);
    temp = reshape(temp,[prod(size(temp))/r(i), r(i)]);
    temp = temp*reshape(G{i},[r(i), prod(size(G{i}))/r(i)]);
    dim = [dim(1:i) n(i) r(i+1)];
    temp = reshape(temp,dim);
end

%temp = round((2^bits-1)*temp)/(2^bits-1);

temp = reshape(temp,dim(2:end));

end