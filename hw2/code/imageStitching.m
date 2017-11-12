function [panoImg] = imageStitching(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

pano_out = [800, 1500];

warp_im1=warpH(img2,H2to1,size(img2));
imshow(warp_im1);
save('results/q6_1.mat','H2to1');

[H1 W1 Z1] =size(img1);
[H2 W2 Z2] =size(img2);
Idendity=eye(3);

%% Mask Image 1
im1mask = zeros(size(img1,1),size(img1,2));
im1mask(1,:) = 1; 
im1mask(end,:) = 1; 
im1mask(:,1) = 1; 
im1mask(:,end) = 1;
im1mask = bwdist(im1mask,'city');
im1mask = im1mask/max(im1mask(:));


%% Warping
mask1_warped = warpH(im1mask, Idendity, pano_out);
warp_im1 = warpH(img1, Idendity, pano_out);
result1 = warp_im1 .* mask1_warped;

%% Masing Image 2
im2mask = zeros(size(img2,1),size(img2,2));
im2mask(1,:) = 1; 
im2mask(end,:) = 1; 
im2mask(:,1) = 1; 
im2mask(:,end) = 1;
im2mask = bwdist(im2mask,'city');
im2mask = im2mask/max(im2mask(:));

%% Warping
mask2_warped = warpH(im2mask, H2to1, pano_out);
warp_im2 = warpH(img2, H2to1, pano_out);
result2 = warp_im2 .* mask2_warped;

%% Final panorama
panoImg = (result1 + result2) ./ (mask1_warped + mask2_warped);

imwrite('results/q6_1.jpg',panoImg);
imshow(panoImg);



end
