function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% INPUT
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear
%         equation
%
% OUTPUT
% Blends img1 and warped img2 and outputs the panorama image

%% Intiliaztion of the parameters
Hout=800;           %% output H and W of the panoromic image
Wout=1800;
[H1 W1 Z1] =size(img1);
[H2 W2 Z2] =size(img2);

%warp_im1=warpH(img2,H2to1,size(img1)+size(img2));
%imshow(warp_im1);

%% Finding the corner points of image 2

corner_top_left=[1;1;1];
corners_bottom_left=[1;size(img2,1);1];
corners_top_right=[size(img2,2);1;1];
corners_bottom_right=[size(img2,2);size(img2,1);1];
corners_matrix=[corner_top_left corners_bottom_left corners_top_right corners_bottom_right];

%% Transfomed Points
img2_corners_transformed=H2to1*corners_matrix;
img2_corners_transformed=img2_corners_transformed./img2_corners_transformed(end,:);  % get x,y

%% New width and heigth of the panoromic image
translate_width = min(min(img2_corners_transformed(1,:)), 1);
width = max(max(img2_corners_transformed(1,:)), W1) - translate_width;

translate_height = min(min(img2_corners_transformed(2,:)), 1);
height = max(max(img2_corners_transformed(2,:)), H1) - translate_height;

%% Scaling the images for panorama
lambda = Wout / width;
out_size = [ceil(lambda * height) Wout];

%% Calculate the Matrix
M1= [lambda 0 -translate_width];
M2= [ 0 lambda -translate_height];
M3= [0 0 1];
M=[M1; M2; M3];

%% Image Stiching 

% Masking the Image 1:
mask_img1 = zeros(size(img1,1), size(img1,2), size(img1,3));
mask_img1(1,:) = 1; mask_img1(end,:) = 1; mask_img1(:,1) = 1; mask_img1(:,end) = 1;
mask_img1 = bwdist(mask_img1, 'city');
mask_img1 = mask_img1/max(mask_img1(:));
mask1_warped = warpH(mask_img1, M, out_size);

warped1 = im2double(warpH(img1, M, out_size));
result1 = warped1 .* mask1_warped;

% Masking the Image 2:
mask_img2 = zeros(size(img2,1), size(img2,2), size(img2,3));
mask_img2(1,:) = 1; mask_img2(end,:) = 1; mask_img2(:,1) = 1; mask_img2(:,end) = 1;
mask_img2 = bwdist(mask_img2, 'city');
mask_img2 = mask_img2/max(mask_img2(:));

mask2_warped = warpH(mask_img2, M * H2to1, out_size);
warped2 = im2double(warpH(img2, M * H2to1, out_size));
result2 = warped2 .* mask2_warped;
panoImg = (result1 + result2) ./ (mask1_warped + mask2_warped);

imwrite(panoImg,'results/q6_2.jpg');
imshow(panoImg);

end