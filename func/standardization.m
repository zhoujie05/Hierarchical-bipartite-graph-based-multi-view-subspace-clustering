function T = standardization(T,gnd)
v = length(T);   % the number of views
    n = length(gnd); % the number of instance
    for i = 1 :v
        for  j = 1:n
            T{i}(j,:) = ( T{i}(j,:) - mean( T{i}(j,:) ) ) / std( T{i}(j,:) ) ;
        end
    end
end