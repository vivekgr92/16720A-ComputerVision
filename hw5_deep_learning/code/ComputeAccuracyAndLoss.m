function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
[~,N] = size(data);
[~,C] = size(labels);
assert(size(W{1},2) == N, 'W{1} must be of size [~,N]');
assert(size(b{1},2) == 1, 'b{1} must be of size [~,1]');
assert(size(b{end},2) == 1, 'b{end} must be of size [~,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,~]');

%Your code here
[D,N] = size(data);
%% Call classify
[outputs] = Classify(W, b, data);

%% Calulate Loss

loss=0;
for i=1:D
    %labels=labels';
%     loss = loss + labels(:,i) .* -log(outputs(:,i));
    loss = loss + sum(- labels(i,:).*log(outputs(i,:)));
end
    loss=loss/D;  %% Loss/7800

%% Accuracy
correct=0;
incorrect=0;
%labels=labels';  % So that the below function can be executed
    for m=1:D
       [~,I] =max(outputs(m,:));  % Predicted Output
       [~,I1]=max(labels(m,:));  % Trained labels
       if I==I1
            correct=correct+1;
        else
            incorrect=incorrect+1;
        end

    end
    accuracy=(correct/D)*100;
    
end
