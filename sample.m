clear all
clc
close all

dataset = 'cal500'  % Dataset name
address1 = [dataset '.mat'];       % Dataset address
address2 = [dataset '_index.mat'];  % Cross-validation
load(address1); 
load(address2);
result = {};
for trial = 1:5   % 5次2折交叉验证
    for i=1:2   
        index=indices(:,trial);
        starttime=cputime;
        testsum = (index == i);
        trainsum = ~testsum;
        train_data = data(trainsum,:);
        test_data = data(testsum,:);
        train_target = target(:,trainsum);
        test_target = target(:,testsum);
        begintime = cputime;
        [pre] = MLHC(train_data,train_target,test_data,test_target,350,'sig',200,0);
        overtime = cputime;
        run_time = overtime - begintime;
        result{trial,i} = pre;
    end
end

clear address1 address2 begintime data dataset i index indices overtime pre testsum
clear train_data train_target trainsum trial run_time starttime target test_data test_target 





