function [X,Cost,Mu] = graph_matching(camPair,features,P,val)
 
    M=size(camPair,1);
    X=cell(M,1);Cost=cell(M,1);Mu=zeros(M,1);

    for j=1:M
        a=camPair(j,1);   
        b=camPair(j,2); 

        cam_a=features{a};
        cam_b=features{b};

        lena=length(features{a});
        lenb=length(features{b});
        if lena<lenb
            Graph_Cost = compute_node_cost(cam_a,cam_b,P{j},val);
        else
            Graph_Cost = compute_node_cost(cam_b,cam_a,P{j},val);
        end
        mu = mean(Graph_Cost(:));               Mu(j)=mu;     Cost{j}=Graph_Cost;
        Graph_Cost = Graph_Cost-mu;           
        Graph_Cost = log(1 + exp( Graph_Cost ));
        [assignX,score] = hungarian(Graph_Cost); 
        X{j}=assignX;   
    end
end