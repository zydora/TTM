function m = maxpool(x)
% input 4d
mm = size(x);
for k = 1:mm(3)
    for q = 1:mm(4)
        for i  = 1:mm(1)/2
            for j = 1:mm(2)/2
                m(i,j,k,q) = max(reshape(x((i-1)*2+1:i*2,(j-1)*2+1:j*2,k,q),[4,1]));
            end
        end
    end
end
end