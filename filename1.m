%for i = 1:7
    %clear
    %filename = ['C:\Users\eee\Desktop\Codes\TTM-master\data\test',num2str(i),'_600.mat'];
    %load(filename);
reconstruction_error = tensornorm(ProTTSVD(G)-reshape(TrainImages(:,1:600),[7,7,20,20,24]));
clear e; clear TestImages; clear TestLabels; clear TrainLabels; clear TrainImages
filename = ['test', num2str(7),'_600.mat'];
save(filename);
%end
clear