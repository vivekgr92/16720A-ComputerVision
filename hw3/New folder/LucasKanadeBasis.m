function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect,bases)
% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y]zxc in the x- and y-directions.

%It is the initial image frame at some arbitary point
%It1 is the image frame at the next instance

%Convert every input frame to double
It=im2double(It);
It1=im2double(It1);

%Get the rectangle 
x=rect(1):rect(3);
y=rect(2):rect(4);
[X1,Y1]=meshgrid(round(x),round(y));
image_template = interp2(It,X1,Y1);


% Initialization
dp_x=0;
dp_y=0;
deltap=0.2;
p=[0 0];

%Calculating the Gradient
[dx,dy] = gradient(double(It1));


%Calculation of the Bases
[x,y,~]=size(bases);
B=reshape(bases(:,:,1:10),[x*y,10]); % Getting 10 Bases in the form of x*y
[bx,by,~]=size(B);
I=eye(bx);
count=0;

 while((norm(deltap))>=0.1)
     
     if count==100;
         break;
     end
     count=count+1;
     %"Warping"
     [X,Y]=meshgrid((rect(1):rect(3))+p(1),(rect(2):rect(4))+p(2));
     Iwarp=interp2(It1,X,Y);
     
     % "Compute Error"
     b = (image_template - Iwarp);
     
     % "Warp Gradient"
     Ix=interp2(dx,X,Y);
     Iy=interp2(dy,X,Y);
     
     %step four from lucas kanade - "Evaluate Jacobian"
%     %J = eye(size([Ix(:) Iy(:)]));

     %Steepest Descent 
     %step five from lucas kanade - "Compute Hessian"
     SD=([Ix(:) Iy(:)]);  % Matrix Dimension Error-47*55 becoming 47*54
     
     A1=(I-B*B')*SD;
     H = A1'*A1;
     b1=(I-B*B')*b(:);
     
     %"Compute delta p"
     deltap = H\A1'*b1;
     
    % "Update p"
     p(1)=p(1)+deltap(1);
     p(2)=p(2)+deltap(2);
 end
 
 % Update the parameters
 dp_x=p(1);
 dp_y=p(2);
end