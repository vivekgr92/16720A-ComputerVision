% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, p1, p2, R and P to q3_3.mat

%Load the images
img1 = imread('im1.png');
img2 = imread('im2.png');

% Load the camera instrinsics matrices
load('intrinsics.mat');

% Load some correspondences--provided
load('some_corresp.mat');

% Calculate the scaling factor M (Max of both the images)
M = max([size(img1), size(img2)]);

% Calculate fundamental matrix using 8-point algorithm
F = eightpoint(pts1, pts2, M);

%Essential Matrix
E  = essentialMatrix( F, K1, K2 );

% Finding the Camera Projection Matrix for Camera 2
M2s = camera2(E);

%%Testing 3.3
M1=[1 0 0 0;
    0 1 0 0;
    0 0 1 0];
C1=K1*M1;

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

%% Best M2
best_M2=M2s(:,:,best);
P=best_P;
M2=best_M2;
C2=K2*M2s(:,:,best);
p1=pts1;
p2=pts2;
%% Saving the Results
save('./matlab/q3_3.mat','M2','C2','p1','p2','P');   

        
    
    
