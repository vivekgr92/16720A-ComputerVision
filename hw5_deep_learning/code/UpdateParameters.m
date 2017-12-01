function [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate)
% [W, b] = UpdateParameters(W, b, grad_W, grad_b, learning_rate) computes and returns the
% new network parameters 'W' and 'b' with respect to the old parameters, the
% gradient updates 'grad_W' and 'grad_b', and the learning rate.
assert(size(W{1},1) == size(grad_W{1},1) & size(W{1},2) == size(grad_W{1},2),'Size of W and grad_W should be equal');
assert(size(W{end},1) == size(grad_W{end},1) & size(W{end},2) == size(grad_W{end},2),'Size of W and grad_W should be equal');
assert(length(b{1}) == length(grad_b{1}),'Size of b and grad_b should be equal');
assert(length(b{end}) == length(grad_b{end}),'Size of b and grad_b should be equal');

%Your code
%% Updating the weights
W{1}=W{1}-learning_rate*grad_W{1};
W{2}=W{2}-learning_rate*grad_W{2};

%% Updating the biases
b{1}=b{1}-learning_rate*grad_b{1};
b{2}=b{2}-learning_rate*grad_b{2};

assert(size(W{1},1) == size(grad_W{1},1) & size(W{1},2) == size(grad_W{1},2),'Size should not change after updates');
assert(length(b{1}) == length(grad_b{1}),'Size should not change after updates');
end

