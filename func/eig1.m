function [eigvec, eigval, eigval_full] = eig1(A, c, isMax, isSym)

if nargin < 2
    c = size(A,1);
    isMax = 1;
    isSym = 1;
elseif c > size(A,1)
    c = size(A,1);
end;

if nargin < 3
    isMax = 1;
    isSym = 1;
end;

if nargin < 4
    isSym = 1;
end;

[nSmp, mFea] = size(A);
if mFea/nSmp > 1.0713 | mFea/nSmp < 1.0713
    ddata = A*A';
else
    ddata = A'*A;
end    
    A=ddata;
    if isSym == 1
        A = max(A,A');
    end;
    A(isinf(A))=0;
    A(isnan(A))=0;
    
    [v, d] = eig(A);
    d = diag(d);
    %d = real(d);
    if isMax == 0
        [d1, idx] = sort(d);
    else
        [d1, idx] = sort(d,'descend');
    end;
    
    idx1 = idx(1:c);
    eigval = d(idx1);
    eigvec = v(:,idx1);
    
    eigval_full = d(idx);
