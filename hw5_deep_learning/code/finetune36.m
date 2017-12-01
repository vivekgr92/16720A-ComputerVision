num_epoch =5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')
load('../data/nist26_model_60iters.mat', 'W');
load('../data/nist26_model_60iters.mat', 'b');

N=layers(1); % The Size of the data 32*32
H=layers(2); % No of hidden layers
Output=layers(3);

W{2} = normrnd(0,0.1,[Output,H]);
b{2} =normrnd(0,0.1,[Output,1]);
%% Shuffle the data
shuffle=randperm(length(train_data)); 
shuffledata=train_data(shuffle,:);
shufflelablel=train_labels(shuffle,:);

ech for j = 1:num_epoch
    [W, b] = Train(W, b, shuffledata, shufflelablel, learning_rate);

    [train_acc, train_loss] = ComputeAccuracyAndLoss(W, b, shuffledata, shufflelablel);
    [valid_acc, valid_loss] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);


    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc, valid_acc, train_loss, valid_loss)
    
    %% For plotting
    epochnumber(j,:)=j;
    trainacc(j,:)=train_acc;
    validacc(j,:)=valid_acc;
    trainloss(j,:)=train_loss;
    validloss(j,:)=valid_loss;
end

%% Actual Plotting
 save('plot3_1_1.mat','epochnumber','trainacc','validacc','trainloss','valid_loss');
 figure(1)
 plot(epochnumber, trainacc,'g',epochnumber,validacc,'r'), xlabel('Epoch Number'), ylabel('Accuracy'), title('Epoch Number vs Accuracy'),legend('Training', 'Validation')
 figure(2)
 plot(epochnumber, trainloss,'g',epochnumber,validloss,'r'), xlabel('Epoch Number'), ylabel('Loss'), title('Epoch Number vs Loss'),legend('Training', 'Validation')

 save('../data/nist36_model.mat', 'W', 'b');
