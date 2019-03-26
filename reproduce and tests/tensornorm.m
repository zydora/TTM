function c = tensornorm(M)
M = reshape(M,[size(M,1),prod(size(M))/size(M,1)]);
c = norm(M,'fro');
end