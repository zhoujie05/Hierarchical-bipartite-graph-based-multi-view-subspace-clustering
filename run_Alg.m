clc;clear
addpath dataset func Evaluation;

dataname={'handwritten'};
name = dataname{1};
load(strcat(name,'.mat'))
X = standardization(X,Y);
k = length(unique(Y)); %number of cluster
n = size(X{1},1);

% parameter setting
p1 = [1000 900 800 700];
p2 = [300 200 150];

for ii=1:length(p1)
    opts.p1 = p1(ii);
    for jj=1:length(p2)
        opts.p2=p2(jj);
        opts.kmMaxIter = 30;
        opts.maxWghtIter = 20;
        
        maxinum_run = 10;
        [our_ari ourResult runTime MetricTime]=deal([]);
        
        %% main procedure
        id = 1;
        for i = 1:maxinum_run
            tic;
            [label,marks1,marks2,clusternum] = MVHG(X, k, opts);
            runTime(i)=toc;
            
            if clusternum  == k
                % metric
                tic
                all_index(id,:) = allClusteringMeasure(label, Y);% [ACC, NMI, Purity, ARI, Fscore, Precision, Recall]
                MetricTime(i) = toc;
                id=id+1;
            end
            disp(['Run times： ' num2str(i)])
        end
        
        meanTime=mean(runTime);
        [std_results ,~,~] = cal_std_var(all_index);
        all_index(all(all_index == 0, 2), :) = [];
        allValue=[mean(all_index,1) meanTime opts.p1 opts.p2];  % data set clustering result on all evaluation indicates
        
        disp(mean(all_index,1))
        disp(['***********The test data name is: ' num2str(name) '************'])     
    end
end

