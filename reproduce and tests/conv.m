function M1 = conv(M,WW)
% M is image tensor, WW is convolutional layer
% both 4-way tensor
for i = 1:size(WW,3)
for j =1:size(WW,4)
WWW(:,:,i,j) = Convert_toeplitz(WW(:,:,i,j),M(:,:,1,1));
end
end
WWW = reshape(WWW,[size(WWW,1),size(WWW,2)*size(WWW,3),size(WWW,4)]);
MM = reshape(M,[size(M,1)*size(M,2)*size(M,3),70000]);
M1 = reshape(permute(WWW,[3,1,2]),[size(WWW,3)*size(WWW,1),size(WWW,2)])*MM;
M1 = reshape(M1,[size(M,1)-size(WW,1)+1,size(M,1)-size(WW,1)+1,size(WW,4),70000]);
end