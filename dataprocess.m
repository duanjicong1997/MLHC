function [clu_lab,lab_clu] = dataprocess(Ncluster,target,cw) 
	% clu_lab£ºClass clusters corresponding to labels
    % lab_clu£ºLabels corresponding to class clusters
    [number,row]=size(target); 
    Ja_dis = pdist(target,'jaccard');   
    clu_val = linkage(Ja_dis,cw); 
    clu_res = cluster( clu_val,'maxclust', Ncluster );  
    lab_clu = [clu_res target]; 
    [number,row]=size(lab_clu); 

    clu_lab = [];  
    for x = 1:Ncluster    
        j = 0;
        for i = 1:number  
            if x == lab_clu(i,1)
                j = j+1;
                clu_lab(x,j) = i;
            end
        end
    end

    for i = 1:Ncluster             
        temp(i) = i;       
    end
    clu_lab = [temp.' clu_lab];

    for i = 1:Ncluster
        n = 0;
        for j = 2:size(clu_lab,2)
            if clu_lab(i,j) ~= 0
                n = n+1;
            end
        end
    end
end

