function [pre] = MLHC(train_data,train_target,test_data,test_target,NumberofHiddenNeurons,ActivationFunction,c,q) 
 %% Initialization
Ncluster = fix(size(train_target,1)/5); 
if q == -2 
    Ncluster = size(train_target,1);
end

%% Encodin
cw = 'average';
% Data Processing
[train_x] = datpro_mian(Ncluster,train_data,train_target,cw,q);
TTtab = cre_TTtab(train_x,train_data,train_target,test_data,test_target,q);  % ×Ü±í
% Data Processing 1: Hierarchical Clustering
% Data Processing 2: Coding Process
% Data Processing 3: Record Mapping

%% Training Process
for ii = 1:size(TTtab,1)
	train = TTtab{ii,2};
	test = TTtab{ii,6+q};
	number = TTtab(ii,3:5+q);
	number = cell2mat(number);
	number(find(number == 0)) = [];  
	class_num = 2^(size(number,2));  
	cre_seq = 1:class_num;                   % Creating Incremental Sequences
	uninum_arr = unique(test(:,1)).';        % Test set uniqueness serial number
	uninum_row = unique(TTtab{ii,2}(:,1)).'; % Training set uniqueness ordinal
	uninum_row  = union(uninum_row,uninum_arr);                
	uni_class = [];                
	for iii=1:length(cre_seq)
        if ~any(uninum_row==cre_seq(iii))
            uni_class = [uni_class cre_seq(iii)];
        end
    end
    % Calling a multi-class classifier (LW-ELM as an example)
	[a,TY] = lwELM(size(number,2),train, test, 1, NumberofHiddenNeurons , ActivationFunction ,c);
	TY = TY.';
	TTtab{ii,8+q} = a;
	temp1 = [];
	for jj = 1: size(TY,1)
        [m,p] = max(TY(jj,:));
        temp1(jj,1) = p;
    end
	TTtab{ii,7+q} = [temp1 TY];           
	TTtab{ii,9+q} = [temp1 TTtab{ii,6+q}(:,1)]; 
end
labsum = [];
label = TTtab(:,3:5+q);
temp3 = [];

%% Decoding
for ii = 1:size(TTtab,1)
	tem_lab = [];
	temp2 = label(ii,:);   
	temp2 = cell2mat(temp2); 
	temp2(find(temp2 == 0)) = []; 
	temp3 = [temp3 temp2];    
	l_num = size(temp2,2);        
	br_table = erjinzhi(l_num);
	br_table(:,1) = [];
	for jj = 1:size(test,1)
        temp4 = br_table(TTtab{ii,9+q}(jj,1),1:l_num);
        tem_lab = [tem_lab;temp4];
	end
	labsum = [labsum tem_lab];
end

%% Projected Results
labsum = [temp3;labsum];
labsum=sortrows(labsum',1)';
labsum(1,:) = [];
pre = labsum';  % Final Result






