function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

It = im2double(image1);
It1 = im2double(image2);
threshold=0.08;

%% Warping Image It using M
M = LucasKanadeAffine(It, It1);
out_size=size(It1);
Iwarp=warpH(It, M, out_size);



%% Computing the Mask
%size(Iwarp(1:240,1:320))
diff = abs(It - Iwarp);
%figure, imagesc(diff);
mask= diff>threshold;

%Removing  the noise
mask = medfilt2(mask);
S = strel('disk', 8);
mask = imdilate(mask, S);
mask = imerode(mask, S);
mask = mask - bwareaopen(mask, 500);

%% For debugging
%figure, imagesc(mask);
%figure, imshow(diff);
%ims=imfuse(It,mask);
%imagesc(ims);

   
 