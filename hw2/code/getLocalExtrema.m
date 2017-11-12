function locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, ...
                        PrincipalCurvature, th_contrast, th_r)
%%Detecting Extrema
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels  - The levels of the pyramid where the blur at each level is
%               outputs
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the
%                      curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a
%               DoG response magnitude above this threshold
% th_r        - remove any edge-like points that have too large a principal
%               curvature ratio
%
% OUTPUTS
% locsDoG - N x 3 matrix where the DoG pyramid achieves a local extrema in both
%           scale and space, and also satisfies the two thresholds.

Dgpyramid = padarray(DoGPyramid,[1 1 1],'replicate','both');   % zero padding for all the levels- so it will be 7 levels
[row,col,lvl]=size(Dgpyramid);                                 % 1-5 and two zero padded levels up and down

num_int=1;

%% Generating the interest points by comparing the pixels with its neighbours
    for k=2:lvl-1
      for i=2:row-1
          for j=2:col-1
          interestpixel=Dgpyramid(i-1:i+1,j-1:j+1,k);              %% Generating padding for 3*3 patch
          interestpixel=interestpixel(:);
          size_ip=size(interestpixel,1);
          interestpixel(size_ip+1)=Dgpyramid(i,j,k-1);              %% Get the pixel from the level below
          interestpixel(size_ip+2)=Dgpyramid(i,j,k+1);              %% Get the pixel from the level above
    %% Maxima and Minima of the the pixels      
          maxima=all(interestpixel<=Dgpyramid(i,j,k));              
          minima=all(interestpixel>=Dgpyramid(i,j,k));
    %% Comparing the pixels with the constraints given 
          if (maxima==true||minima==true)&& abs(Dgpyramid(i,j,k))>th_contrast && PrincipalCurvature(i-1,j-1,k-1)<th_r && PrincipalCurvature(i-1,j-1,k-1)>0
              interestpoints(num_int,:)=[j-1 i-1 k-1];   %% NOTE here X and Y are Flipped
              num_int=num_int+1;
          end
         
          end
      end
    end  
    locsDoG=interestpoints;

    size(interestpoints);
end
    

