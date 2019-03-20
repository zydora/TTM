% Reproduce ternary network: "TERNARY WEIGHT DECOMPOSITION AND BINARY
% ACTIVATION ENCODING FOR FAST AND COMPACT NEURAL NETWORK" 
%Algo.1
function [M,a,R] = TerDecom(W,r)
tic
R = W;
fprintf('TerDecom starts!\n');
for i = 1:r
    
    M(:,i) =sign(round(randn(size(W,1),1)));
    a(i,:) = (M(:,i)'*R/(M(:,i)'*M(:,i)));
    iter = 0;
    while(1)&&(iter < 50)
         index  = [1,0,-1];tempsum = [0,0,0];
        for j = 1:size(W,1)
            for q = 1:3
                tempsum(q) = (R(j,:)-index(q)*a(i,:))*(R(j,:)-index(q)*a(i,:))';
            end
            if isnan(min(tempsum))
                fprintf('exist NaN');
                M(j,i) = index(1);
            else
                M(j,i) = index(find(tempsum == min(tempsum),1));
            end
                
        end
        iter = iter + 1;
        a(i,:) = (M(:,i)'*R/(M(:,i)'*M(:,i)));
    end
    R = R - M(:,i)*a(i,:);
    if norm(R)<10^-2
        return
    end
    fprintf('iter %d/%d completed\n',i,r);
end
toc
end
       