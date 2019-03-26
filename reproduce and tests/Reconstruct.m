function [W,error,ee] = Reconstruct(W,sh,r,bits)
T = reshape(W,sh);
i = bits;
    %tic
    [G,ee] = TerTTSVD((T),0.01,r,2*ones(length(r)-1,1),i) % ee is each error
    error = tensornorm(ProTTSVD(G)-T);
    W  = ProTTSVD(G);
    %toc
%     filename = ['test',num2str(i),'.mat'];
%     save(filename)
%end
end