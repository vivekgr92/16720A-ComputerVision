img1 = imread('im1.png');
img2 = imread('im2.png');

load('intrinsics.mat');

%cpselect(img1,img2);

% Load some correspondences--provided
load('some_corresp.mat');

% Calculate the scaling factor M (Max of both the images)
M = max([size(img1), size(img2)]);

% Calculate fundamental matrix using 8-point algorithm
F = eightpoint(pts1, pts2, M);

%Tesing the F Matrix
%displayEpipolarF(img1, img2, F);

% Testing 7 Point
%F= sevenpoint( pts1, pts2, M );

%Tesing the F Matrix
%displayEpipolarF(img1, img2, F{1});

% %Essential Matrix
E  = essentialMatrix( F, K1, K2 );

% Finding the Camera Projection Matrix for Camera 2
M2s = camera2(E);

%%Testing 3.3
M1=[1 0 0 0;
    0 1 0 0;
    0 0 1 0];
C1=K1*M1;
C2=K2*M2s(:,:,1);
[P, err ] = triangulate( C1, pts1, C2, pts2 );


