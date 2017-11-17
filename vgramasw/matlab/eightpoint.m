function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup




%% Scaling the Points Point Normalization 
pts1=pts1/M;
pts2=pts2/M;

%% Get the Points for building A matrix
X1=pts1(:,1);
Y1=pts1(:,2);
X2=pts2(:,1);
Y2=pts2(:,2);

%% Detrmine the A matrix -> AF=0 where F is the Fundamental Matrix
%A=[ X1.*X2 X1.*Y2 X1 Y1.*X2 Y1.*Y2 Y1 X2 Y2 ones(size(X1))];

A=[ X2.*X1 X2.*Y1 X2 Y2.*X1 Y2.*Y1 Y2 X1 Y1 ones(size(X1))];

%% Least Square approximation using SVD
[~,~,V]=svd(A);
f=V(:,9);
f = V(:,9);
F = reshape(f,3,3)';   % Because th reshape takes in this order  1     4     7
                                                                %2     5     8
                                                                %3     6     9
%% Enforcing Rank 2 approximation as Fudamental matrix should have rank 2
[U,S,V]=svd(F);
S(3,3)=0;  % Rank Reduction- Setting the F33 element to Zero
F=U*S*V';

%% Refining F using local minimization of the geometric cost
F=refineF(F,pts1,pts2);

%% Scaling/Normalization matrix                                  1/M  0     0
                                                                 %0   1/M   0 
                                                                 %0   0     1  
T=eye(3)/M;
%Setting the last diagonal element as 1
T(3,3)=1;

%% Unscaling the F matirx
F=T'*F*T;

%% Saving parameters
save('./matlab/q2_1.mat','F','M','pts1','pts2');   

end

