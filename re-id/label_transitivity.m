function [ assignX, PlusX] = label_transitivity(cam_pair,Y)

C=size(cam_pair,1);
assignX=cell(1,C);PlusX=cell(1,C);
for i=1:C
%     temp1=cell(1,4);        temp2=cell(1,4);
    k1=1;k2=1;
    a=cam_pair(i,1);
    b=cam_pair(i,2);
    for j=1:C
        if (cam_pair(j,1)==a && cam_pair(j,2)~=b)||(cam_pair(j,2)==a && cam_pair(j,1)~=b)
            temp1{k1}=Y{j};k1=k1+1;
        elseif(cam_pair(j,1)==b && cam_pair(j,2)~=a)||(cam_pair(j,2)==b && cam_pair(j,1)~=a)
            temp2{k2}=Y{j};k2=k2+1;
        end
    end
    plusX=Y{i};tempX=Y{i};
    [m,n]=size(Y{i});loopX=zeros(m,n);
    for u=1:length(temp1) 
        X=zeros(size(tempX));
        if size(temp1{u},1)==size(Y{i},1) && size(temp2{u},2)==size(Y{i},2)
            Xa=temp1{u};Xb=temp2{u};        X=Xa*Xb;
        elseif size(temp1{u},1)==size(Y{i},1) && size(temp2{u},1)==size(Y{i},2)
            Xa=temp1{u};Xb=temp2{u}';       X=Xa*Xb;       
        elseif size(temp1{u},2)==size(Y{i},1) && size(temp2{u},2)==size(Y{i},2)
            Xa=temp1{u}';Xb=temp2{u};        X=Xa*Xb;
        elseif size(temp1{u},2)==size(Y{i},1) && size(temp2{u},1)==size(Y{i},2)
            Xa=temp1{u}';Xb=temp2{u}';        X=Xa*Xb;  

        elseif size(temp2{u},1)==size(Y{i},1) && size(temp1{u},2)==size(Y{i},2)
            Xa=temp2{u};Xb=temp1{u};        X=Xa*Xb;
        elseif size(temp2{u},1)==size(Y{i},1) && size(temp1{u},1)==size(Y{i},2)
            Xa=temp2{u};Xb=temp1{u}';             X=Xa*Xb;      
        elseif size(temp2{u},2)==size(Y{i},1) && size(temp1{u},2)==size(Y{i},2)
            Xa=temp2{u}';Xb=temp1{u};        X=Xa*Xb;
        elseif size(temp2{u},2)==size(Y{i},1) && size(temp1{u},1)==size(Y{i},2)
            Xa=temp2{u}';Xb=temp1{u}';            X=Xa*Xb;                     
        end
        
        for v=1:m
            for t=1:n
                if tempX(v,t)==1&&X(v,t)==1
                    loopX(v,t)=1;
                end
            end
        end
        
        plusX = plusX+X;
    end
    assignX{i}=loopX;  
    PlusX{i} = plusX;
end
end
