function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q3.2:
%       Implement a triangulation algorithm to compute the 3d locations
%
P=[];

%% Calculating  the A matrix
for i=1:length(p1)
    % Take points from the first image
    x1p=p1(i,1)*C1(3,:)-C1(1,:);
    y1p=p1(i,2)*C1(3,:)-C1(2,:);
    
    % Take points from the second image
    x2p=p2(i,1)*C2(3,:)-C2(1,:);
    y2p=p2(i,2)*C2(3,:)-C2(2,:);
    
    % Concatenate the A matrix
    A=[x1p;y1p;x2p;y2p];
    [~,~,V]=svd(A);
    P=V(:,4); % Taking the last element
    
    %%Removing the last element
    P=P(1:3,1)./P(4,1);
    % Changing it to 1*3 form
    Pprime(i,:)=P';
end
for j=1:length(p1)
    ptemp=Pprime(j,:);  %% change to 3*1
    ptemp=ptemp';
    P_new=[ptemp;1]; %% to bring it in the form of X Y Z 1
    
    %% Projection Points
    p1cap1=C1*P_new;    %% Result will be 3*1
    p2cap1=C2*P_new;
    
    p1cap11=p1cap1(1:2,1)./p1cap1(3,1); %% x y  form
    p1cap(j,:)=p1cap11'; %% to be in the form of 1*2
    
    p2cap22=p2cap1(1:2,1)./p2cap1(3,1); %% x y  form
    p2cap(j,:)=p2cap22'; %% to be in the form of 1*2
    
end

err=(norm(p1-p1cap))^2+(norm(p2-p2cap))^2;
P = Pprime;
end
    
    
    
    
    
    
    
