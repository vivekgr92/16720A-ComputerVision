function [W, b] = InitializeNetwork(layers)
% InitializeNetwork([INPUT, HIDDEN, OUTPUT]) initializes the weights and biases
% for a fully connected neural network with input data size INPUT, output data
% size OUTPUT, and HIDDEN number of hidden units.
% It should return the cell arrays 'W' and 'b' which contain the randomly
% initialized weights and biases for this neural network.

% Your code here
N=layers(1); % The Size of the data 32*32
H=layers(2); % No of hidden layers
Output=layers(3);

W=cell(2,1);
b=cell(2,1);

%% Weights 1 --> Input layer to hidden layer
W{1} = normrnd(0,0.1,[H,N]);
b{1} =normrnd(0,0.1,[H,1]);

%% Weights 2 --> Hidden layer to output
W{2} = normrnd(0,0.1,[Output,H]);
b{2} =normrnd(0,0.1,[Output,1]);

C = size(b{end},1);
assert(size(W{1},2) == 1024, 'W{1} must be of size [H,N]');
assert(size(b{1},2) == 1, 'b{end} must be of size [H,1]');
assert(size(W{end},1) == C, 'W{end} must be of size [C,H]');

end
