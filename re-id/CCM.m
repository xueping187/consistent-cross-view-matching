camera=1:6;
camPairs=nchoosek(camera,2);    N=size(camPairs,1);

P=cell(1,N);
initP=eye(2048);
for i=1:N
    P{i}=initP;
end
XX = cell(1,10);
val = 0; 
[center_fea]=center_sequence(camPairs,cam_feat);
for iter = 1:5
    disp(['Experiment No.',num2str(iter) '.......']) 
    [X,Cost,Mu] = graph_matching(camPairs,cam_feat,P,val);  clear P

    XX{iter}=X;
    [assignX,PlusX] = label_transitivity(camPairs,X);
   
    for i=1:N
        tempX=zeros(size(PlusX{i}));
        if iter< 3
            tempX(PlusX{i}>1)=1; 
        else
            tempX(PlusX{i}>0)=1;
        end  

        LC_X{i}=tempX;
        [a,b]=find(tempX==1);
        u=[a,b];
        T{iter}{i}=u;
        disp(['the number of positive image pairs: ',  num2str(size(b,1))])       
    end
    [ P ] = updating_metric( LC_X,Mu,center_fea,N);  
    dist = dis_1235(N, feat_query,feat_gallery, P);
    [CMC_eu, map_eu] = evaluation_market(dist', label_gallery, label_query, cam_gallery, cam_query);
    CMC(iter,:)=CMC_eu;
    mAP(iter,:)=map_eu;    
end
