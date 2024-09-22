function [spiltCentSet,spiltClusterAssume] = BK(dataSet,K)
curCluster=dataSet;
% [ind,center,sumd,D] = kmeans(curCluster,K);
[ind, center, ~, sumD, D] = litekmeans(curCluster,K);

[DD,Order]=min(D,[],2);
spiltClusterAssume=[Order DD];
spiltCentSet=center;
end