% Your code here.

load('../data/nist26_train.mat')
classes = 26;
layers = [32*32, 400, classes];

%% Gradient Checker
%Define Epsilon
epsilon=10^-4;
[W, b] = InitializeNetwork(layers);
diffchek={};
for h=1:2 %max(size(W))
randIndx=randperm(length(W{h}));

        %% Weights in Layer
        %h=2;   % 1 for W{1} 2 for w{2}

        for i=1:4

        %% Select Random Weights
        randweight=W{h}(randIndx(i));
        randweigth1=randweight;
        randOrig=randweight;

        %% Adding with Epsilon
        randweight = randweight + epsilon;
        W{h}(randIndx(i)) = randweight;
        X=train_data(1,:)';
        Y=train_labels(1,:)';

        %% First Loop with addition
        [output, act_h, act_a] = Forward(W, b,X);
        loss=0;
        for m=1:1
            loss = loss + sum(- train_labels(m,:).*log(output(m,:)));
        end
        loss1=loss;

        %% Second Loop with Subtraction
        randweight1=randweigth1-epsilon;
        W{h}(randIndx(i))=randweight1;
        [output, act_h, act_a] = Forward(W, b,X);
        loss=0;
        for p=1:1
            loss = loss + sum(- train_labels(p,:).*log(output(p,:)));
        end
        loss2=loss;

        %%Backward
        W{h}(randIndx(i))=randOrig;
        [output, act_h, act_a] = Forward(W, b,X);
        [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a);

        new_grad_W=grad_W{h}(randIndx(i));

        %% Computing

        %Numerical way
        NumGrad=(loss1-loss2)/(2*epsilon);
        diffchek{h}(i,:)=abs(NumGrad-new_grad_W);

        end

end
