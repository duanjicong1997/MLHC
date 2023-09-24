function b = erjinzhi(n)
    b = zeros(2^n,1);
    for i = 0 : (2^n-1)
        c = dec2bin(i,n);
        for j = 1 : n
            b((i+1), 1)= i + 1;
            b((i+1), j+1)= str2double(c(j));
        end
    end
end

