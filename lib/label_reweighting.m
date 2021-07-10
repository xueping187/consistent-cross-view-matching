function Y = label_reweighting(X,BDs)
% label re-weighting

for j=1:length(X)
ProbY = X{j};
c0 = mean(mean(BDs{j}));

% positive reweighting
for i = 1:size(ProbY,1)    
    pos = find(X{j}(i,:)==1); 
    if BDs{j}(i,pos)<=c0
        ProbY(i,pos) = exp(-(BDs{j}(i,pos))/max(BDs{j}(i,:)));
    else
        ProbY(i,pos) = 0.001;
    end
end

% negative  reweighting
ProbY(BDs{j}>c0) = 0.001;
ProbY (ProbY == 0)  = -1;
ProbY (ProbY <= 0.5& ProbY >0) = 0;
Y{j}=ProbY;
end

end
