% im=imread('model_chickenbroth.jpg');
% levels=[-1,0,1,2,3,4];
% k=sqrt(2);
% sigma0=1;
% th_contrast=0.03;
% th_r=12;
% patchWidth=9;
% nbits=256;
% 
% GaussianPyramid=createGaussianPyramid(im, 1,k,levels);
% displayPyramid(GaussianPyramid);
% [DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
% displayPyramid(DoGPyramid);
% PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
% locsDoG=getLocalExtrema(DoGPyramid, DoGLevels,PrincipalCurvature, th_contrast, th_r);
% [locsDoG, GaussianPyramid]=DoGdetector(im, 1, k, levels, th_contrast, th_r);
% [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
% [locs,desc] = computeBrief(im, GaussianPyramid, locsDoG, k, ...
%                                         levels, compareA, compareB)
%                                     
                                    
% p1=[];
% p2=[];
%       total=length(matches);
%       random_points=randperm(total,4);               % Random 4 points are taken from the locs1 and locs2 corresponding to matches index
%         for j=1:4
%         in=matches(random_points(j),:);
%         x1=locs1(matches(random_points(j)),:);
%         in2=matches(random_points(j),end);
%         x2=locs2(in2,:);
%         x1=x1';
%         x2=x2';
%         p1=cat(2,p1,x1(1:end-1));
%         p2=cat(2,p2,x2(1:end-1));
%        % p1(:,:)=locs1(matches(random_points(j)),:);
%        % p2=locs2(matches(random_points(j)),:);
%         end
% Hmatrix=computeH(p1,p2);        
% imageStitching_noClip(im1, im2, Hmatri

