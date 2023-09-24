function [mul_clsss_tabel] = datpro_mian(Ncluster,data,target,cw,q)
    % Data Processing 1: Hierarchical Clustering
    % Data Processing 2: Coding Process
    % Data Processing 3: Record Mapping
    [clu_lab,lab_clu] = dataprocess(Ncluster,target,cw);         
    [clu_lab_new] = dataprocess2(Ncluster,lab_clu,clu_lab,cw,q); 
    [mul_clsss_tabel] = dataprocess3(target,clu_lab_new,data);   

    % Optimize code to fix logic errors caused by non-existent classes
    if q == -1
        if size(mul_clsss_tabel,2) == 3   
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x];  
        end
    elseif q == 0
        if size(mul_clsss_tabel,2) == 4  
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x]; 
        elseif size(mul_clsss_tabel,2) == 3  
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x l_x]; 
        end
    elseif q == 1
        if size(mul_clsss_tabel,2) == 5   
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x];  
        elseif size(mul_clsss_tabel,2) == 4  
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x l_x];  
        elseif size(mul_clsss_tabel,2) == 3 
            l_x = zeros(size(mul_clsss_tabel,1),1);
            l_x = num2cell(l_x);
            mul_clsss_tabel = [mul_clsss_tabel l_x l_x l_x]; 
        end
    end
end
