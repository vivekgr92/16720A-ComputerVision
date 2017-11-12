function [locs, desc] = briefLite(im)
% INPUTS
% im - gray image with values between 0 and 1
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
% 		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. 
%		 m is the number of valid descriptors in the image and will vary
% 		 n is the number of bits for the BRIEF descriptor

%% Loading the parameters
load('./data/testPattern.mat');
levels=[-1,0,1,2,3,4];
k=sqrt(2);
sigma0=1;
th_contrast=0.03;
th_r=12;

%% Converting Image to Gray scale b/w 0 to 1
im = im2double(im);
if size(im,3)==3
    im=rgb2gray(im);
end
%% Following the Steps in the following manner to generate the best interest points with the descriptors
GaussianPyramid=createGaussianPyramid(im, 1,k,levels);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels,PrincipalCurvature, th_contrast, th_r);
[locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k,levels, compareA, compareB);
end
