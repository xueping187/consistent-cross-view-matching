function [ D_min ] = dis_1235(N, feat_query,feat_gallery, NewP)
%% feature normalization
sum_val = sqrt(sum(feat_query.^2));
for n = 1:size(feat_query, 1)
    feat_query(n, :) = feat_query(n, :)./sum_val;
end
sum_val = sqrt(sum(feat_gallery.^2));
for n = 1:size(feat_gallery, 1)
    feat_gallery(n, :) = feat_gallery(n, :)./sum_val;
end
%% calculate the distance
for i=1:N
%     if ismember(i,seet)
    dist_eucl = EuclidDist(feat_query* NewP{i}, feat_gallery* NewP{i}); 
    dist(:,i) = dist_eucl(:);
%     else
%         continue
%     end
end
Dis_min=min(dist,[],2);
% Dis_mean=mean(dist');
% D_min = reshape(Dis_min,[702,2636]);
% D_min = reshape(Dis_min,[3368,15913]);
D_min = reshape(Dis_min,[1980,12180]);
% D_min = reshape(Dis_min,[2228,17661]);
% D_min = reshape(Dis_min,[11659,82161]);
end

