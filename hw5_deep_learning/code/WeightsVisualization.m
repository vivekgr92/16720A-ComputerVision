% % 3.1.3
% initial weight
% layers = [32*32, 400, 26];
% [W, ~] = InitializeNetwork(layers);
% 
% % final weight
% %load('../data/nist26_model_01learning.mat');
% 
% W_visual = reshape(W{1}', 32, 32, 1, 400);
% 
% for i = 1:400
%     W_visual(:,:,1,i) = mat2gray(W_visual(:,:,1,i));
% end
% 
% montage(W_visual);

% % 3.2,2
 %initial weight
%load('../data/nist26_model_60iters.mat', 'W', 'b')

% final weight
 load('../data/nist36_model.mat');

W_visual = reshape(W{1}', 32, 32, 1, 800);

for i = 1:800
    W_visual(:,:,1,i) = mat2gray(W_visual(:,:,1,i));
end

montage(W_visual);
% Add C
% omment Collapse

