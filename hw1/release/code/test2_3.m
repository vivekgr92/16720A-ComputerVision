load('histograms.mat','histograms');
load('sun_aastyysdvtnkdcvt.mat');
wordHist=getImageFeaturesSPM(wordMap,350);
histInter=distanceToSet(wordHist,histograms);