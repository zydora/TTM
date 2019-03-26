% Reproduce ternary network: "TERNARY WEIGHT DECOMPOSITION AND BINARY
% ACTIVATION ENCODING FOR FAST AND COMPACT NEURAL NETWORK" 
%Algo.1
function [M,a,R] = TerDecomExhaust(W,r)
% NOT finished
tic
R = W;[d1,d2] = size(W);
fprintf('TerDecom starts!\n');
for j = 1:r
    
    M(:,j) =sign(round(randn(size(W,1),1)));
    
    iter = 0;
    while(1)&&(iter < 150)
        %index  = [1,0,-1];tempsum = [0,0,0];
        a(j,:) = (M(:,j)'*R/(M(:,j)'*M(:,j)));
        for i = 1:d1
            
            index(i) = 1;
            tempsum = 100;
            %for i = 1:size(MM,1)
            for k = 1:3^d1
                tM = str2num(dec2base(k,3));
                for q = 1:d1
                    MM(q) = floor(mod((tM),10^(d1-q+1))/10^(d1-q));
                end
                MM = MM-1;
                temp(k) = (x(j)-MM*c-b)'*(x(j)-MM*c-b)%%%%%%%%%%%%%%%
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
                    batch1 = batch1+1;
                    fprintf('batch %d ends, total %d\n',batch1,3^r/10000);
                end
            end
            iter = iter + 1;
            for q = 1:3
                tempsum(q) = (R(i,:)-index(q)*a(j,:))*(R(i,:)-index(q)*a(j,:))';
                M(i,j) = index(find(tempsum == min(tempsum),1));
            end
        end
        iter = iter + 1;
        %a(i,:) = (M(:,i)'*R/(M(:,i)'*M(:,i)));
    end
    R = R - M(:,j)*a(j,:);
    fprintf('iter %d/%d completed\n',j,r);
end
toc
end
       