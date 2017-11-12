function [ F ] = sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup



real_roots=[];
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

                                                                
%% Find two vectors that span null space of A (F1 and F2)---> alpha*F1+(1-alpha)*F2
[~,~,V]=svd(A);
f1=V(:,9);
F1 = reshape(f1,3,3)'; 
f2=V(:,8);
F2 = reshape(f2,3,3)';

%% To calculate alpha such that det(alpha * F1 + (1 - alpha) * F2) = 0
syms alphac
result=det(alphac * F1 + (1 - alphac) * F2);

%Solving the Equation
alpha=solve(result==0);
alpha = double(alpha);      % Use double precision to round off
q=alpha(1)
w=alpha(2)
t=alpha(3)

%% Finding Real Roots
for i=1:3                        % Max possible root is 3
    if(isreal(alpha(i)))
        real_roots(i) = alpha(i);
    end
end

%% Scaling/Normalization matrix                                  1/M  0     0
                                                                 %0   1/M   0 
                                                                 %0   0     1  
T=eye(3)/M;
%Setting the last diagonal element as 1
T(3,3)=1;
%% Calculate the candidate Fundamental matrices F--> in a cell array
F = cell(1, length(real_roots));


for i = 1 : length(real_roots)
    F{i} = real_roots(i) * F1 + (1 - real_roots(i)) * F2;

    % Refine the calculated fundamental matrix
    F{i} = refineF(F{i}, pts1, pts2);
    
    % Unscale F matrix
    F{i} = T' * F{i} * T;
end

save('./data/q2_2.mat','F','M','pts1','pts2'); 

end

