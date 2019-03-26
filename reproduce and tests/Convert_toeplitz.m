function AA = Convert_toeplitz(A,x)
% convert kernel A into toeplitz matrix, in convenience of production with
% Images x(:)
[mA,nA] = size(A); [mX,nX] = size(x);
for i = 1:mA
    for j = 1:mX+mA-1
        tA = [zeros(mA,mX-1),fliplr(A),zeros(mA,mX-1)];
        H{i}(j,:) = tA(i,size(tA,2)-nX+1-j+1:size(tA,2)-j+1);
    end
end
tAA  =[zeros(size(H{1},1),(mX-1)*size(H{1},2))];
for i = 1:mA
    tAA = [tAA, H{mA-i+1}];
end
tAA = [tAA, zeros(size(H{1},1), (mX-1)*size(H{1},2))];
HH = zeros((mX+mA-1)^2,(mX)^2);
for i = 1:mX+mA-1
    HH((mX+mA-1)*(i-1)+1:i*(mX+mA-1),:) = tAA(:,size(tAA,2)-(mX)^2+1-(i-1)*mX:size(tAA,2)-(i-1)*mX);
end
A = zeros(mX-mA+1,mX-mA+1);
for i = 1:mX-mA+1
    if i == 1
        temp = (mA+mX)*(mA-1)+(mX-mA+1);
        AA((i-1)*(mX-mA+1)+1:i*(mX-mA+1),:) = HH((mA+mX)*(mA-1)+1:(mA+mX)*(mA-1)+(mX-mA+1),:);
    else
        temp = temp+ 2*(mA-1);
        AA((i-1)*(mX-mA+1)+1:i*(mX-mA+1),:) = HH(temp+1:temp+(mX-mA+1),:);
        temp = temp+(mX-mA+1);
    end
end

end