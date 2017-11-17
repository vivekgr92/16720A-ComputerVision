% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3


%% Load the images
img1 = imread('im1.png');
img2 = imread('im2.png');

%% Load the camera instrinsics matrices
load('intrinsics.mat');

%% Loading the temple coordinates
load('templeCoords.mat');
% Load some correspondences--provided
load('some_corresp.mat');

%% Calculate the scaling factor M (Max of both the images)
M = max([size(img1), size(img2)]);

%% Finding F matrix
F = eightpoint(pts1, pts2, M);

%% Finding E matrix
E  = essentialMatrix( F, K1, K2 );


%% Finding the Camera Projection Matrix for Camera 2
M2s = camera2(E);

M1=[1 0 0 0;
    0 1 0 0;
    0 0 1 0];
C1=K1*M1;

%% Finding the Best M2
for i=1:length(M2s)
    C2=K2*M2s(:,:,i);  % Checking for the best M2s
    [P, err ] = triangulate( C1, pts1, C2, pts2 );
    lastcolumn=P(:,3);
    if max(lastcolumn<0)==0
        best=i;
        % Best P
        best_P=P;
    end
end

best_M2=M2s(:,:,best);

C2=K2*best_M2;
M2=best_M2;

%% Finding Correspondences

for i=1:length(x1)
    
    [ x2, y2 ] = epipolarCorrespondence( img1, img2, F, x1(i), y1(i) );
    x_2(i,:)=x2;
    y_2(i,:)=y2;
    pts_2=[x_2 y_2];

end
pts_1=[x1 y1];
%% Triangulate
[P, err ] = triangulate( C1, pts_1, C2, pts_2 );

%% Visualization
scatter3(P(:,1),P(:,2),P(:,3));


%% Saving parameters
save('./matlab/q4_2.mat','F','M1','M2','C1','C2');  