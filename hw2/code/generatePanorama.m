function [panoImg] = generatePanorama(im1, im2)

im1 = im2double(im1);
im2 = im2double(im2);
nIter=500;
tol=5;
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);
[matches] = briefMatch(desc1, desc2,0.5);
%plotMatches(im1, im2, matches, locs1, locs2);
H2to1 = ransacH(matches, locs1, locs2, nIter, tol);
%imageStitching(im1, im2, H2to1)
imageStitching_noClip(im1, im2, H2to1);

end