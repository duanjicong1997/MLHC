function [a,TY] = lwELM(class_num,train_data, test_data, Elm_Type, NumberofHiddenNeurons, ActivationFunction,C)

tic;
%%%%%%%%%%% Macro definition
REGRESSION=0;
CLASSIFIER=1;


%%%%%%%%%%% Load training dataset
P= train_data(:,2:size(train_data,2))';   
%%%%%%%%%%% Load testing dataset
TV.P=test_data(:,2:size(test_data,2))';  

NumberofTrainingData=size(P,2);     
NumberofTestingData=size(TV.P,2);   
NumberofInputNeurons=size(P,1);     

LT = train_data(:,1);    
TV.LT = test_data(:,1); 

T = zeros(class_num,size(LT,1));
for ii = 1:size(LT,1)
    T(LT(ii,1),ii) = 1;
end

a = T;
T=T*2-1;   

[nl,ni1]=size(T);        
Positive_T=zeros(1,nl); 
for i=1:nl              
  num=0;                 
  for j=1:ni1            
    if(T(i,j)==1)        
      num=num+1;         
    end
  end
   Positive_T(1,i)=sqrt((ni1-num)/num);    

end
for i=1:nl              
  for j=1:ni1              
     if(T(i,j)==1)      
       T(i,j)=Positive_T(1,i);
     end
  end
end

InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;  
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1); 
tempH=InputWeight*P;    
clear P;                                           % Release input of training data 
ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);             % Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH=tempH+BiasMatrix;

%%%%%%%%%%% Calculate hidden neuron output matrix H
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H = 1 ./ (1 + exp(-tempH));
    case {'sin','sine'}
        %%%%%%%% Sine
        H = sin(tempH);    
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H = double(hardlim(tempH));
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H = tribas(tempH);
    case {'radbas'}
        %%%%%%%% Radial basis function
        H = radbas(tempH);
        %%%%%%%% More activation functions can be added here                
end
clear tempH;                                        %   Release the temparary array for calculation of hidden neuron output matrix H

%%%%%%%%%%% Calculate output weights OutputWeight (beta_i)
n = NumberofHiddenNeurons;
OutputWeight=((H*H'+speye(n)/C)\(H*T'));

%%%%%%%%%%% Calculate the training accuracy
Y=(H' * OutputWeight)';                             %   Y: the actual output of the training data
clear H;

%%%%%%%%%%% Calculate the output of testing input
start_time_test=cputime;
tempH_test=InputWeight*TV.P; % TV.P±Í«©ºØ
clear TV.P;             %   Release input of testing data             
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);              %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tempH_test=tempH_test + BiasMatrix;
switch lower(ActivationFunction)
    case {'sig','sigmoid'}
        %%%%%%%% Sigmoid 
        H_test = 1 ./ (1 + exp(-tempH_test));
    case {'sin','sine'}
        %%%%%%%% Sine
        H_test = sin(tempH_test);        
    case {'hardlim'}
        %%%%%%%% Hard Limit
        H_test = hardlim(tempH_test);        
    case {'tribas'}
        %%%%%%%% Triangular basis function
        H_test = tribas(tempH_test);        
    case {'radbas'}
        %%%%%%%% Radial basis function
        H_test = radbas(tempH_test);        
        %%%%%%%% More activation functions can be added here        
end
TY=(H_test' * OutputWeight)';                      %   TY: the actual output of the testing data
end_time_test=cputime;
TestingTime=end_time_test-start_time_test;     %   Calculate CPU time (seconds) spent by ELM predicting the whole testing data

end
