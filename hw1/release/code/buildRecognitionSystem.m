function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	%load('dictionary.mat');
	%load('../data/traintest.mat');
    %%load('../data/traintest.mat'); 
    load('../data/dictionary.mat'); 
    load('../data/train_features.mat');
    load('../data/traintest.mat','train_labels');
    save('vision.mat','filterBank','dictionary','train_features','train_labels');

end