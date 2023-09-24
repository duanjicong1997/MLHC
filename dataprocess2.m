function [clu_lab_new] = dataprocess2(Ncluster,lab_clu,clu_lab,cw,q)
    clu_lab_new = clu_lab;
    while 1
        zzsave = zeros;
        for i = 1:size(clu_lab_new,1) 
            z = 0;
            for j = 2:size(clu_lab_new,2) 
                if clu_lab_new(i,j) ~= 0 
                    z = z+1;
                end
            zzsave(1,i) = z;
            end
        end
        zzmax = max(zzsave);
        if zzmax > 3+q
            flag = 1;
            while flag
                for i2 = 1:size(clu_lab_new,1)        
                    zz = 0;
                    for j = 1:size(clu_lab_new,2)
                        if clu_lab_new(i2,j) ~= 0
                            zz = zz + 1;
                        end
                    end
                    if zz > 3+q
                        flag = 1;
                        temp = clu_lab_new(i2,2:size(clu_lab_new,2));  
                        rex = backtab(temp,lab_clu);
                        flag = 0;
                        reNcluster = 2;      
                        rey = pdist(rex,'jaccard');    
                        rez = linkage(rey,cw);
                        rec = cluster( rez,'maxclust', reNcluster ); 
                        rex2 = [rec rex];       
                        n = 0;                   
                        temp(temp==n) = []; 
                        rex2 = [temp.' rex2]; 
                        rex3 = zeros(reNcluster,size(clu_lab,2)-1);
                        for i3 = 1:reNcluster   
                            j2 = 0;
                            for j4 = 1:size(rex2,1)   
                                if i3 == rex2(j4,2)
                                    j2 = j2 + 1;
                                    rex3(i3,j2) = rex2(j4,1);
                                end
                            end
                        end

                        clu_lab_new(i2,:)=[];                    
                        clu_lab_new(:,1) = [];
                        clu_lab_new = [clu_lab_new;rex3];
                        % !!!!!!!!!!!!!  i2
                        for i3 = 1:size(clu_lab_new,1)            
                            lin(i3) = i3;       
                        end
                        clu_lab_new = [lin.' clu_lab_new];
                        break
                    end
                end
            end
        else              
            clu_lab_new(:,all(clu_lab_new == 0,1)) = [];    
            break
        end
    end
end











        
        
    

