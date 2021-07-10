function [ Y ] = re_weighting( X,Graph_Cost )

lambda=0.6;
[m,n]=size(X); t=1:m;column=1:n;
max_cost=max(Graph_Cost(t,:));
for i=1:m
    Cost(i,:)=exp(-(Graph_Cost(i,:)/max_cost(i)));   
end
pos_cost(t)=Graph_Cost(X==1);

[value]=sort(pos_cost,'descend');
ind=floor(lambda*m):m;
temp_cost=value(1,ind);

mm=0;
for i=t
    for j=column
        if (X(i,j)==1) && (ismember(Graph_Cost(i,j),temp_cost))
            Cost(i,j)=0;  mm=mm+1;
        end
    end
end

Y=X.*Cost;
% Y(Y==0)=-1;
end




% lambda=0.95;
% 
% [value,index]=sort(pos_cost,'ascend');
% 
% 
% [r,c]=find(X==1);
% 
% ProbY = X{j};
% c0 = mean(mean(BDs{j}));
% 
% % positive reweighting
% for i = 1:size(ProbY,1)    
%     pos = find(X{j}(i,:)==1); 
%     if BDs{j}(i,pos)<=c0
%         ProbY(i,pos) = exp(-(BDs{j}(i,pos))/max(BDs{j}(i,:)));
%     else
%         ProbY(i,pos) = 0.001;
%     end
% end
% 
% % negative  reweighting
% ProbY(BDs{j}>c0) = 0.001;
% ProbY (ProbY == 0)  = -1;
% ProbY (ProbY <= 0.5& ProbY >0) = 0;
% Y{j}=ProbY;

