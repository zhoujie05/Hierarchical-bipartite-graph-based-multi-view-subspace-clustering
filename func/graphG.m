function S = graphG(data,marks,opts,r)

nSmp = size(data{1},1);
p = size(marks{1},1);
numView = size(data,2);
for iView = 1:numView
    D = EuDist2(data{iView},marks{iView},0);
    
    if isfield(opts,'sigma')
        sigma = opts.sigma;
    else
        sigma = mean(mean(D));
    end
    
    dump = zeros(nSmp,r);
    idx = dump;
    for i = 1:r
        [dump(:,i),idx(:,i)] = min(D,[],2);
        temp = (idx(:,i)-1)*nSmp+[1:nSmp]';
        D(temp) = 1e100;
    end
    
    dump = exp(-dump/(2*sigma^2));
      
    sumD = sum(dump,2);
    Gsdx = bsxfun(@rdivide,dump,sumD);
    Gidx = repmat([1:nSmp]',1,r);
    Gjdx = idx;
    Z = sparse(Gidx(:),Gjdx(:),Gsdx(:),nSmp,p);
    
    Z(isinf(Z)) = 0;
    Z(isnan(Z)) = 0;
    
    S{iView}=Z;
end
clear dump
end