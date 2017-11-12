function [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
                                        levels, compareA, compareB)
%%Compute BRIEF feature
% INPUTS
% im      - a grayscale image with values from 0 to 1
% locsDoG - locsDoG are the keypoint locations returned by the DoG detector
% levels  - Gaussian scale levels that were given in Section1
% compareA and compareB - linear indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors
%
% OUTPUTS
% locs - an m x 3 vector, where the first two columns are the image coordinates 
%		 of keypoints and the third column is the pyramid level of the keypoints
% desc - an m x n bits matrix of stacked BRIEF descriptors. m is the number of 
%        valid descriptors in the image and will vary

%% Initialization

[row,col] = size(im);
desc=[];
locs=[];
patch=[];

%% Choosing the Interest points which does not lie on the edges: 
for i=1:length(locsDoG)   
 if locsDoG(i,1)>4 && locsDoG(i,1)<(col-4)&& locsDoG(i,2)>4 && locsDoG(i,2)<(row-4)   %% Row col interchanges w r t the interest points
     locs=cat(1,locs,locsDoG(i,:));       %% This locs contains interest points which are centered around the images
 end                                      %% 9*9 image patch so that we have sufficient space to have a patch over it
end

%% Compare the pixel intensities of the neighbouring levels for generating the 256 bits descriptors
for i=1:length(locs)
    patch=GaussianPyramid(locs(i,2)-4:locs(i,2)+4,locs(i,1)-4:locs(i,1)+4);   %% Patch of 9*9 on the Guassian pyramid
    find(levels==locs(i,3));
    desc(i,:)=patch(compareA)<patch(compareB);                                %% compare the intensities  
     
end 
  
%% Display the images
%imshow(im);
%hold on;
%plot(locs(:,1),locs(:,2),'r*' );    
end
