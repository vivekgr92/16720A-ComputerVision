h=[];
%zeros(2100,1);
for i=1:length(wordHist)
    histograms=wordHist{i};
    h=cat(2,h,histograms);
end
histograms=h;
%h(:,2:end);
train_features=histograms;
save('../data/histograms.mat','histograms');
save('../data/train_features.mat');