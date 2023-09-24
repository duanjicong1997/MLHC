function [rex] = backtab(temp,xx2)   
    rex = [];
    n = 0;
    temp(temp==n) = []; 
    temp(2);
    size(xx2,1);
    for i = 1:size(temp,2)     
        x =  xx2(temp(i),:);
        rex = [rex;x];
    end
    rex(:,1) = [];              
end