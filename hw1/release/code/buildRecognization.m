function buildRecognization()
load('../data/traintest.mat'); 
load('../data/dictionary.mat'); 
load('../data/traintest.mat'); 

filterBank = createFilterBank();

wordHist={};
wordMaps=train_imagenames;
for i=1:length(wordMaps)
    image=wordMaps{i};
    image(1,(end-3):end)='.mat';
    wordMapNames{i}=strcat(['../data/'],image);
end
for i=1:length(wordMapNames)
    wordMaps{i}=load(wordMapNames{i});
end
wordMap=wordMaps{1};
%wordMap.wordMap
for i=1:length(wordMaps)
wordHist{i}=getImageFeaturesSPM(3,wordMaps{i}.wordMap, size(dictionary,2));
end
size(wordHist);
train_labels=wordHist;
train_labels=train_labels';
save('../data/vision.mat','filterBank','dictionary','train_features','train_labels');
