function [Ind,bestCentSet]=BisK_means(biDataSet,biK)

%%
[row,col] = size(biDataSet);
% 
biCentSet = zeros(biK,col);
ind=1;
numCluster = 1;
biClusterAssume = zeros(row,2);
biCentSet(1,:) = mean(biDataSet);

for i = 1:row
    biClusterAssume(i,1) = numCluster;
    biClusterAssume(i,2) = distEclud(biDataSet(i,:),biCentSet(1,:));
end
%
SSE=zeros(biK,1);

%%
while numCluster < biK
    % find the best cluster to partition
    curCluster = biDataSet(find(biClusterAssume(:,1) == ind),:);
    
    [spiltCentSet,Assume] = BK(curCluster,2);
    
    spiltClusterAssume=Assume;
    numCluster=numCluster+1;
    
    split=spiltClusterAssume(spiltClusterAssume(:,1)==1,2);
    split1= spiltClusterAssume(spiltClusterAssume(:,1)==2,2);
    
    SSE(ind)=sum(split);
    SSE(numCluster)=sum(split1);
    
    biCentSet(ind,:)=spiltCentSet(1,:);
    biCentSet(numCluster,:)=spiltCentSet(2,:);
    bestCentSet = biCentSet;
    
    spiltClusterAssume(find(Assume(:,1)==1),1)=ind;
    spiltClusterAssume(find(Assume(:,1)==2),1)=numCluster;
    %
    biClusterAssume(find(biClusterAssume(:,1)==ind),:) = spiltClusterAssume;
    %
    [MAXsse,ind]=max(SSE);
    curCluster = biDataSet(find(biClusterAssume(:,1) == ind),:);
    
end
   Ind=biClusterAssume(:,1) ;
