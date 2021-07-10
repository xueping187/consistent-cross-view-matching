function [ X_out ] = pairs_selection( X_in )
%PAIRS_SELECTION Summary of this function goes here
%   Detailed explanation goes here

camera=1:6;
camPairs=nchoosek(camera,2);    N=size(camPairs,1);
[LoopX,PlusX] = label_transitivity(camPairs,X_in);

X_out=cell(1,N);

for i=1:N
    tempX=zeros(size(PlusX{i}));
    tempX(PlusX{i}>0)=1;        
    X_out{i}=tempX;
    [a,b]=find(tempX==1);
    u=[a,b];
    T{iter}{i}=u;
    disp(['the number of positive image pairs: ',  num2str(size(b,1))])       
 end     


end

