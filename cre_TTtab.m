function [train_x] = cre_TTtab(train_x,train_data,train_target,test_data,test_target,q)
    test_target = test_target;
    tab = train_x(:,3:5+q);
    tab = cell2mat(tab);
    for i = 1:size(train_x,1)
        temp = tab(i,:);
        temp(find(temp == 0)) = [];         
        temp = test_target(temp,:).';
        temp2 = temp * 2.^[size(temp,2)-1:-1:0].';
        temp3 = [temp2+1 test_data]; 
        train_x{i,6+q} = temp3;
    end
end

