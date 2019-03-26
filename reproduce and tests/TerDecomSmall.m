% Reproduce ternary network: "TERNARY WEIGHT DECOMPOSITION AND BINARY
% ACTIVATION ENCODING FOR FAST AND COMPACT NEURAL NETWORK" 
%Algo.2
function [M,c,b] = TerDecomSmall(x,r)
MM = Gen_ind([1,2,3],r)-2;
Index =  randperm(size(MM,1));

for i = 1:size(x,1)
    M(i,:) = MM(Index(i),:);
end
b = 5;
iter = 0;
while(1)&&(iter < 50)
    fprintf('iter %d starts\n',iter+1);
    c  = pinv(M'*M)*(M'*(x-b*ones(size(x))));
    b = ones(size(x))'*(x-M*c)/size(M,1);%index  = [1,0,-1];tempsum = [0,0,0];
    for j = 1:size(M,1)
        index(j) = 1;
        tempsum = 100;
        for i = 1:size(MM,1)
            temp(i) = (x(j)-MM(i,:)*c-b)'*(x(j)-MM(i,:)*c-b);
            if temp(i) < tempsum
                tempsum = temp(i);
                index(j) = i;
            end
        end
        M(j,:) = MM(index(j),:);
    end
    iter = iter + 1;
end
end
       