function [mul_clsss_tabel] = dataprocess3(target,clu_lab_new,data) 
    clu_lab2 = clu_lab_new;
    Ncluster = size(clu_lab_new,1);
    mul_class = cell(Ncluster,size(clu_lab2,2));
    for i = 1:Ncluster
        n = 0;
        for j = 2:size(clu_lab2,2)
            if clu_lab2(i,j) ~= 0
                n = n+1;
            end
        end
    end   
    for i = 1:size(mul_class,1)
        temp{i,1} = i;
           for j = 2:size(clu_lab2,2)
                mul_class{i,j} = clu_lab2(i,j);
           end
    end
    mul_class = [temp mul_class];
      for i = 1:Ncluster
        mul_class2 = mul_class(i,3:size(mul_class,2));  
        mul_class2 = cell2mat(mul_class2);              
        mul_class2(find(mul_class2 == 0)) = [];         
        mul_class3 = target(mul_class2,:).';            
        mul_class4 = mul_class3 * 2.^[size(mul_class3,2)-1:-1:0].'; 
        mul_class5 = [mul_class4+1 mul_class3]; 
        mul_class{i,2} = mul_class5; 
      end

    mul_clsss_tabel = mul_class;
    for i = 1:size(mul_class,1)
        temp = mul_class{i,2}(:,1);
        temp2 = [temp data];
        mul_clsss_tabel{i,2} = temp2;
    end
end