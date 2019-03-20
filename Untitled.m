% test Ter Decom
%% 
[A,B,R] = TerDecom(((randn(256,4)'*18)),256)
norm(R)