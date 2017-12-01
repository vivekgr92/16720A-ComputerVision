%% Layers

load('../data/nist26_train.mat')


% Image of size 32*32 flatted out into 1024 and you have 7800 images
layers = [32*32, 400, 26];
[W, b] = InitializeNetwork(layers);

%% 2.2.1
%X=train_data(1,:)'
%[output, act_h, act_a] = Forward(W, b,X);

%% 2.2.2
[outputs] = Classify(W, b, train_data);

%% 2.2.3
[accuracy, loss] = ComputeAccuracyAndLoss(W, b, train_data, train_labels);

%% 2.3.1
% X=train_data(1,:)';
% Y=train_labels(1,:)';
% [output, act_h, act_a] = Forward(W, b,X);
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);
% 
% %% 2.3.2
% learning_rate=0.01;
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate)