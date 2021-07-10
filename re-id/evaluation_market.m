function [CMC, map] = evaluation_market(dist, label_gallery, label_query, cam_gallery, cam_query)

rank_size=100;
nQuery=size(label_query);
for k = 1:nQuery
    % load ground truth for each query (good and junk)
    good_index = intersect(find(label_gallery == label_query(k)), find(cam_gallery ~= cam_query(k)))';% images with the same ID but different camera from the query
    junk_index1 = find(label_gallery == -1);% images neither good nor bad in terms of bbox quality
    junk_index2 = intersect(find(label_gallery == label_query(k)), find(cam_gallery == cam_query(k))); % images with the same ID and the same camera as the query
    junk_index = [junk_index1; junk_index2]';
    score = dist(:, k);
    
    % sort database images according Euclidean distance
    [~, index] = sort(score, 'ascend');  % single query
%     index = double(index_50(k,1:30)-3367)';
    % re-rank  select rank_size=1000 index
    index = index(1:rank_size);    
    
    [ap1(k), CMC1(k, :)] = compute_AP(good_index, junk_index, index);% compute AP for single query
end
CMC = mean(CMC1);map=mean(ap1);
clear ap1 CMC1

