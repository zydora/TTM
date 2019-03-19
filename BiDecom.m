function [M,a,R] = BiDecom(W,r)
tic
R = W;
for i = 1:r
    
    M(:,i) =sign(round(randn(size(W,1),1)));
    b(:,i) =sign(round(randn(size(W,1),1)));
    iter = 0;
    while(1)&&(iter < 50)
        a(i,:) = (M(:,i)'*R/(M(:,i)'*M(:,i))); index  = [1,-1];tempsum = [0,0];
        for j = 1:size(W,1)
            for q = 1:2
                tempsum(q) = (R(j,:)-index(q)*a(i,:))*(R(j,:)-index(q)*a(i,:))';
                M(j,i) = index(find(tempsum == min(tempsum),1));
            end
        end
        iter = iter + 1;
    end
    R = R - M(:,i)*a(i,:);
    fprintf('iter %d/%d completed\n',i,r);
end
toc
end