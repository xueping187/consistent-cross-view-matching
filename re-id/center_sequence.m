
function [center_fea]=center_sequence(camPair,features)

M=size(camPair,1);
center_fea=cell(M,2);
for i=1:M
    a=camPair(i,1);      % remainder
    b=camPair(i,2);    % quotient
    cama=features{a};
    camb=features{b};
    lena=length(cama);
    lenb=length(camb);
    
    seqa=zeros(lena,size(cama{i},1));    
    seqb=zeros(lenb,size(camb{i},1));
    for j=1:lena
        temp=max(cama{j},[],2);
        seqa(j,:)=temp';
    end
    for j=1:lenb
        temp=max(camb{j},[],2);
        seqb(j,:)=temp';
    end
    
    if lena<lenb
        prob=seqa;
        gall=seqb;
    else 
        prob=seqb;
        gall=seqa;
    end
    
    sum_val = sqrt(sum(prob.^2));
    for n = 1:size(prob, 1)
        prob(n, :) = prob(n, :)./sum_val;
    end

    sum_val = sqrt(sum(gall.^2));
    for n = 1:size(gall, 1)
        gall(n, :) = gall(n, :)./sum_val;
    end
    
    center_fea{i,1}=prob;
    center_fea{i,2}=gall;
end
end






% function [center_fea]=center_sequence(camPair,cam1_feat,cam2_feat,cam3_feat,cam4_feat,cam5_feat,cam6_feat)
% %UNTITLED Summary of this function goes here
% %   Detailed explanation goes here
% M=size(camPair,2);
% center_fea=cell(M,2);
% k=1;
% for t=1:M
%     camP=camPair(t);
%     switch camP
%         case 12
%             % cam1 and cam2
%             gallFea = zeros(length(cam1_feat),size(cam1_feat{1},1));
%             probFea = zeros(length(cam2_feat),size(cam2_feat{1},1));
%             for i =1:length(cam1_feat)
%                 tmpGallFea = max(cam1_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam2_feat)
%                 tmpProbFea = max(cam2_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%        case 13
%             % cam1 and cam3
%             gallFea = zeros(length(cam3_feat),size(cam3_feat{1},1));
%             probFea = zeros(length(cam1_feat),size(cam1_feat{1},1));
%             for i =1:length(cam3_feat)
%                 tmpGallFea = max(cam3_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam1_feat)
%                 tmpProbFea = max(cam1_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
%   
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 14
%             % cam1 and cam4
%             gallFea = zeros(length(cam1_feat),size(cam1_feat{1},1));
%             probFea = zeros(length(cam4_feat),size(cam4_feat{1},1));
%             for i =1:length(cam1_feat)
%                 tmpGallFea = max(cam1_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam4_feat)
%                 tmpProbFea = max(cam4_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea; k=k+1;
%  
%         case 15
%             % cam1 and cam5
%             gallFea = zeros(length(cam1_feat),size(cam1_feat{1},1));
%             probFea = zeros(length(cam5_feat),size(cam5_feat{1},1));
%             for i =1:length(cam1_feat)
%                 tmpGallFea = max(cam1_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam5_feat)
%                 tmpProbFea = max(cam5_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 16
%             % cam1 and cam6
%             gallFea = zeros(length(cam1_feat),size(cam1_feat{1},1));
%             probFea = zeros(length(cam6_feat),size(cam6_feat{1},1));
%             for i =1:length(cam1_feat)
%                 tmpGallFea = max(cam1_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam6_feat)
%                 tmpProbFea = max(cam6_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 23
%             % cam2 and cam3
%             gallFea = zeros(length(cam3_feat),size(cam3_feat{1},1));
%             probFea = zeros(length(cam2_feat),size(cam2_feat{1},1));
%             for i =1:length(cam3_feat)
%                 tmpGallFea = max(cam3_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam2_feat)
%                 tmpProbFea = max(cam2_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 24
%             % cam2 and cam4
%             gallFea = zeros(length(cam2_feat),size(cam2_feat{1},1));
%             probFea = zeros(length(cam4_feat),size(cam4_feat{1},1));
%             for i =1:length(cam2_feat)
%                 tmpGallFea = max(cam2_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
% 
%             for j =1:length(cam4_feat)
%                 tmpProbFea = max(cam4_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 25
%             % cam2 and cam5
%             gallFea = zeros(length(cam5_feat),size(cam5_feat{1},1));
%             probFea = zeros(length(cam2_feat),size(cam2_feat{1},1));
%             for i =1:length(cam5_feat)
%                 tmpGallFea = max(cam5_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam2_feat)
%                 tmpProbFea = max(cam2_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 26
%             % cam2 and cam6
%             gallFea = zeros(length(cam6_feat),size(cam6_feat{1},1));
%             probFea = zeros(length(cam2_feat),size(cam2_feat{1},1));
%             for i =1:length(cam6_feat)
%                 tmpGallFea = max(cam6_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam2_feat)
%                 tmpProbFea = max(cam2_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 34
%             % cam3 and cam4
%             gallFea = zeros(length(cam3_feat),size(cam3_feat{1},1));
%             probFea = zeros(length(cam4_feat),size(cam4_feat{1},1));
%             for i =1:length(cam3_feat)
%                 tmpGallFea = max(cam3_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam4_feat)
%                 tmpProbFea = max(cam4_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 35
%             % cam3 and cam5
%             gallFea = zeros(length(cam3_feat),size(cam3_feat{1},1));
%             probFea = zeros(length(cam5_feat),size(cam5_feat{1},1));
%             for i =1:length(cam3_feat)
%                 tmpGallFea = max(cam3_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam5_feat)
%                 tmpProbFea = max(cam5_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 36
%             % cam3 and cam6
%             gallFea = zeros(length(cam3_feat),size(cam3_feat{1},1));
%             probFea = zeros(length(cam6_feat),size(cam6_feat{1},1));
%             for i =1:length(cam3_feat)
%                 tmpGallFea = max(cam3_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam6_feat)
%                 tmpProbFea = max(cam6_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 45
%             % cam4 and cam5
%             gallFea = zeros(length(cam5_feat),size(cam5_feat{1},1));
%             probFea = zeros(length(cam4_feat),size(cam4_feat{1},1));
%             for i =1:length(cam5_feat)
%                 tmpGallFea = max(cam5_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam4_feat)
%                 tmpProbFea = max(cam4_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 46
%             % cam4 and cam6
%             gallFea = zeros(length(cam6_feat),size(cam6_feat{1},1));
%             probFea = zeros(length(cam4_feat),size(cam4_feat{1},1));
%             for i =1:length(cam6_feat)
%                 tmpGallFea = max(cam6_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam4_feat)
%                 tmpProbFea = max(cam4_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%         case 56
%             % cam5 and cam6
%             gallFea = zeros(length(cam5_feat),size(cam5_feat{1},1));
%             probFea = zeros(length(cam6_feat),size(cam6_feat{1},1));
%             for i =1:length(cam5_feat)
%                 tmpGallFea = max(cam5_feat{i}, [],2);
%                 gallFea(i,:) = tmpGallFea';
%             end
%             for j =1:length(cam6_feat)
%                 tmpProbFea = max(cam6_feat{j}, [],2);
%                 probFea(j,:) = tmpProbFea';
%             end
% 
%             center_fea{k,1}=probFea;
%             center_fea{k,2}=gallFea;k=k+1;
%     end
% end

