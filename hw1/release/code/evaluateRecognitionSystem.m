function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');
    Confmatrix=zeros(8);

	% TODO Implement your code here

    for i=1:length(test_imagenames)
        image=im2double(imread(test_imagenames{i}));
        wordMap = getVisualWords(image, filterBank, dictionary);
        h = getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        x=train_labels(nnI);
        y=test_labels(i);
        Confmatrix(x,y)=Confmatrix(x,y)+1;
    end
    conf=Confmatrix;
    accuracy=trace(Confmatrix)/sum(Confmatrix(:));
    fprintf('Conf');
    disp(conf);
    fprintf('Accuracy');
    disp(accuracy);
       
        
end