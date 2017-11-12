% Script to test BRIEF under rotations
%% Loading parameters
im1=imread('model_chickenbroth.jpg');
im2=imread('model_chickenbroth.jpg');
[locs1, desc1] = briefLite(im1);
angles=[];
number_matches=[];
j=1;

%% Rotation with 4 angles
for i=0:10:40
    im2=imrotate(im2,i);
    [locs2, desc2] = briefLite(im2);  
    [matches] = briefMatch(desc1, desc2);
    angles(j,:)=i;
    number_matches(j,:)=length(matches);
    j=j+1;
    %plotMatches(im1, im2, matches, locs1, locs2);
end
  % plotMatches(im1, im2, matches, locs1, locs2);
   bar(angles,number_matches);
   
