
%load('../data/nist26_model_01learning.mat'); 
%load('../data/nist26_test.mat','test_data','test_labels');

load('../data/nist36_model'); 
load('../data/nist36_test.mat','test_data','test_labels');

[outputs]=Classify(W,b,test_data);
[~,pred_out]=max(outputs,[],2);
[~,true]=max(test_labels,[],2);
[data,class]=size(outputs);
Confmatrix=zeros(class,class);
max_conf=0;

for i=1:max(size(pred_out))
         Confmatrix(true(i),pred_out(i))=Confmatrix(true(i),pred_out(i))+1;
         if true(i)~=pred_out(i)&& Confmatrix(true(i),pred_out(i))>max_conf
             max_conf=Confmatrix(true(i),pred_out(i));
             predclass=pred_out(i);
             trueclass=true(i);
             fprintf('\n*****');
         end
end
  Confmatrix=mat2gray(Confmatrix);
  imshow(Confmatrix);
  
    disp(predclass)
    disp(trueclass)
    conf=Confmatrix;
    accuracy=trace(Confmatrix)/sum(Confmatrix(:));
    %fprintf('Conf');
    %disp(conf);
    fprintf('Accuracy');
    disp(accuracy);
    
    
  