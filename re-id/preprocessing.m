%% mars dataset

%'cam' stores the camera id information. 
%'train_feas' stores the features of all person images.

CamID=cell(1,6);
for j = 1:6
    k=0;
    for i = 1:8298
        camid = cam(i);
        if camid == j
            k=k+1;
            camids(k)=i;
            feat(k,:) = train_feas(i,:);
        end
    end
    CamFeat{j}=feat;
    CamID{j}=camids;
    clear camids feat
end
%% -------------NEAREST NEIGHBOR-----------------
labels = cell(1,6);
for i=1:6
    feat=CamFeat{i};
    [c, num_clust]= FINCH(feat,[], 1);
    label = c(:,1);
    for j=1:num_clust(1)
        t=1;
        for k=1:size(c,1)
            if label(k)==j
                temp(t,:)=feat(k,:);
                t=t+1;
            end
        end
        Temp{j}=temp';
        clear temp
    end
    cam_feat{i}=Temp;
    clear Temp
end
%% ------------------DBSCAN--------------------------

epsilon=0.1;
MinPts=2;
for i=1:6
    feat = CamFeat{i};
    r=0;
    % label=DBSCAN(feat,epsilon,MinPts);   %DBSCAN
    %------------HDBSCAN-------------
    clusterer = HDBSCAN( double(feat) );
    clusterer.run_hdbscan( 2,4,[],0.85 );
    label = clusterer.model.lastClust;
    for j=1:max(label)
        if ~ismember(j,label)
            continue;
        else           
            r=r+1;t=1;temp=[];
            for k=1:size(label,1)
                if label(k)==j
                    temp(t,:)=feat(k,:);
                    t=t+1;
                end
            end
            Temp{r}=temp';
            clear temp
        end
    end
    cam_feat{i}=Temp;
    clear Temp
    
end


% % for i=1:6
    % % t=1;k=1;
    % % camid=CamID{i};
    % % len=length(camid);
    % % camid(len+1)=0;
    % % for j=1:len
        % % if (camid(j)+1==camid(j+1)&&(label(camid(j))==label(camid(j+1))))
            % % t=t+1;
        % % else
            % % CamCount(k)=t;
            % % tmp(k)=label(camid(j));
            % % t=1;k=k+1;
        % % end
    % % end
    % % Person_count{i}=CamCount;
    % % clear CamCount
% % end


% % cam_feat=cell(1,6);
% % for i=1:6
    % % tmp=CamFeat{i};
    % % cam_feat{i} = feature_mat2cell(tmp',Person_count{i});
% % end