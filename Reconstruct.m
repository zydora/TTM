function [W,error,ee,G] = Reconstruct(W,sh,r,bits)
T = reshape(W,sh);
%tic
[G,ee] = TerTTSVD((T),0.01,r,2*ones(length(r)-1,1),bits) % ee is each error
error = tensornorm(ProTTSVD(G)-T);
W  = ProTTSVD(G);
%toc
%     filename = ['test',num2str(i),'.mat'];
%     save(filename)
%end
end