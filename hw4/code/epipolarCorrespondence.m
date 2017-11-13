function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup

%% Rounding of the input points


%x1=round(x1);  % check
%y1=round(y1);

x1=x1+50;
y1=y1+50;
P1=[x1 y1 ones(size(x1))];

epipolarline=F*P1';  %% Of the form Ax+By+c=0 will get 288 epipolar lines
epipolarline=epipolarline';
syms x y;
[h,~]=size(epipolarline);

corresP=zeros(2,2);
j=1;
PatchWidth=20 ;%7;%ones(size(x1));
%PatchWidth(:)=20;

%% Image padding
img1_Pad=padarray(im1, [50 50], 0, 'both');
img2_Pad=padarray(im2,[50 50],0,'both');
[M,N,~]=size(im2);


M = M + 50;
N = N + 50;



% Equation of the line  50 is added as we have padded the image
for i=1:1 %length(h)

    % (N,*)
    eqn1=epipolarline(i,1)*N+epipolarline(i,2)*y+epipolarline(i,3)==0;
   % yfirst=solve(eqn1,y);
    y=-(epipolarline(i,1)*N)-(epipolarline(i,3))/epipolarline(i,2);
    yfirst=y;
    yfirst=double(yfirst);
    
    if (yfirst>M||yfirst<50)==0
        corresP(j,:)=[N yfirst];
        j=j+1;
    end
    
    % (*,1)
    eqn2=epipolarline(i,1)*x+epipolarline(i,2)*50+epipolarline(i,3)==0;
    %xsecond=solve(eqn2,x);
    x=-(epipolarline(i,2)*50)-epipolarline(i,3)/epipolarline(i,1);
    xsecond=x;
    xsecond=double(xsecond);
    
     if (xsecond>N||xsecond<50)==0
        corresP(j,:)=[xsecond 50];
        j=j+1;
     end
    
     
     % (1,*)
    eqn3=epipolarline(i,1)*50+epipolarline(i,2)*y+epipolarline(i,3)==0;
    %y11=solve(eqn3,y);
    y=-(epipolarline(i,1)*50)-(epipolarline(i,3))/epipolarline(i,2);
    y11=y;
    y11=double(y11);
    
    if (y11>M||y11<50)==0
        corresP(j,:)=[50 y11];
        j=j+1;
    end
    
     
     % (*,M)
    eqn4=epipolarline(i,1)*x+epipolarline(i,2)*M+epipolarline(i,3)==0;
    %x11=solve(eqn4,x); // if you use solve() the system takes in a lot of
    %time
    x=-(epipolarline(i,2)*M)-epipolarline(i,3)/epipolarline(i,1);
    x11=x;
    x11=double(x11);
    
    if (x11>N||x11<50)==0
        corresP(j,:)=[x11 M];
        j=j+1;
    end

 
 %% Finding points on line give two points on line using Linspace
 
 noOfpointsX=linspace(corresP(1,1),corresP(2,1),200);
 noOfpointsY=linspace(corresP(1,2),corresP(2,2),200);
 %noOfpointsX=linspace(corresP(1,1),corresP(2,1),100);
 %noOfpointsY=linspace(corresP(1,2),corresP(2,2),100);
 
 % Rounding the Points
 noOfpointsX=round(noOfpointsX);
 noOfpointsY=round(noOfpointsY);
 
 

 %% Image Patching on image 
 I1=img1_Pad((y1(i)-PatchWidth:y1(i)+PatchWidth),(x1(i)-PatchWidth:x1(i)+PatchWidth));
 %Vectorize I1
 I1_vectorize=I1(:);
 I1_vectorize=I1_vectorize';
 I1_vectorize=double(I1_vectorize);
 
 for q=1:200
     
     if ( noOfpointsY(1,q)<y1(i)+20 && noOfpointsY(1,q)>y1(i)-20 && noOfpointsX(1,q)>x1(i)-20 && noOfpointsX(1,q)<x1(i)+20 )
         I2=img2_Pad((noOfpointsY(1,q)-PatchWidth : noOfpointsY(1,q)+PatchWidth) ,(noOfpointsX(1,q)-PatchWidth : noOfpointsX(1,q)+PatchWidth));
         I2_vectorize=I2(:);
         I2_stack(q,:)= double(I2_vectorize');
     end
 end

 [D,I]=pdist2(I2_stack,I1_vectorize,'euclidean','Smallest',1);
 x2(i,:)=noOfpointsX(I)-50;
 y2(i,:)=noOfpointsY(I)-50;
end
%corresPoints=corresP;
%disp(size(corresPoints));


 






