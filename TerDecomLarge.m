% Reproduce ternary network: "TERNARY WEIGHT DECOMPOSITION AND BINARY
% ACTIVATION ENCODING FOR FAST AND COMPACT NEURAL NETWORK" 
%Algo.2
function [M,c,b] = TerDecomLarge(x,r)
%MM = Gen_ind([1,2,3],r)-2;
%Index =  randperm(size(MM,1));

for i = 1:size(x,1)
    M(i,:) = sign(round(randn(1,r)));
end
b = 5;
iter = 0;
while(1)&&(iter < 50)
    fprintf('iter %d starts\n',iter+1);
    c  = pinv(M'*M)*(M'*(x-b*ones(size(x))));
    b = ones(size(x))'*(x-M*c)/size(M,1);%index  = [1,0,-1];tempsum = [0,0,0];
    batch = 0;
    for j = 1:size(M,1)
        index(j) = 1;
        tempsum = 100;
        %for i = 1:size(MM,1)
        for k = 1:3^r
            tM = str2num(dec2base(k,3));
            for q = 1:r
                MM(q) = floor(mod((tM),10^(r-q+1))/10^(r-q));
            end
            MM = MM-1;
            temp(k) = (x(j)-MM*c-b)'*(x(j)-MM*c-b);
            if temp(k) < tempsum
                tempsum = temp(k);
                index(j) = k;
                if tempsum < 0.01
                    continue
                end
            end
            %end
            tM = str2num(dec2base(index(j),3));
            for q = 1:r
                MM(q) = floor(mod((tM),10^(r-q+1))/10^(r-q));
            end
            MM = MM-1;
            M(j,:) = MM;
            if mod(k,10000)==0
                batch = batch+1;
                fprintf('batch %d ends, total %d\n',batch,3^r/10000);
            end
        end
        iter = iter + 1;
    end
end
       