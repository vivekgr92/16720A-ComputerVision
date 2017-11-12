load('aerialseq.mat');
It=frames(:, :, 1);
It1=frames(:, :, 2);
rect = [60, 117, 146, 152];
%M = LucasKanadeAffineGr(It, It1);
%M = LucasKanadeAffine(It, It1)
mask = SubtractDominantMotion(It, It1);