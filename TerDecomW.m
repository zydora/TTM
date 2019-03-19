% Reproduce ternary network: "TERNARY WEIGHT DECOMPOSITION AND BINARY
% ACTIVATION ENCODING FOR FAST AND COMPACT NEURAL NETWORK" 
%Algo.2
function [M,c,b] = TerDecomW(x,r)
MM = Gen_ind([1,2,3],r)-2;
%for i = 1:r
    Index =  randperm(size(MM,1));
    %Index = Index(1);
    for i = 1:size(x,1)
    M(i,:) = MM(Index(i),:);
    end
    b = 5;
    iter = 0;
    while(1)&&(iter < 50)
        c  = pinv(M'*M)*(M'*(x-b*ones(size(x))));
        b = ones(size(x))'*(x-M*c)/size(M,1);%index  = [1,0,-1];tempsum = [0,0,0];
        for j = 1:size(M,1)
            index(j) = 1;
            tempsum = 100;
            for i = 1:size(Index,1)
                M(j,:) = MM(i,:);
            temp(j) = tempsum;
            temp(j) = (x-M(j,:)*c-b*ones(size(x)))'*(x-M(j,:)*c-b*ones(size(x)));
            if temp(j) < tempsum
                tempsum = temp(j);
                index(j) = i;
            end
            M(j,:) = MM(index(j),:);
            end
        end
        iter = iter + 1;
    end
    %R = R - M(:,i)*c(i,:);
%end
end
       