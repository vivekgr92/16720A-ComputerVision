
load('../data/traintest.mat'); 
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

