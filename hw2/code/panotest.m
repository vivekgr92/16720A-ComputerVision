im1=imread('incline_L.png');
im2=imread('incline_R.png');
%[locs1, desc1] = briefLite(im1);
%[locs2, desc2] = briefLite(im2);
%[matches] = briefMatch(desc1, desc2,0.5);
%plotMatches(im1, im2, matches, locs1, locs2);
nIter=500;
tol=5;
H2to1 = ransacH(matches, locs1, locs2, nIter, tol);
[panoImg] = imageStitching_noClip(im1, im2, H2to1);
%[panoImg] = imageStitching(im1, im2, H2to1)
   %%bar(angles,number_matches);

   
