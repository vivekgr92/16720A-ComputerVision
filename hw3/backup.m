function [dp_x,dp_y] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [dp_x,dp_y] in the x- and y-directions.
%% Initilization of parameters
tol = 0.1;
deltap = 2 * [tol tol]';
p=[0,0]; % initial point
It = im2double(It);
It1=im2double(It1);

%Calculation of the Bases
[x,y,~]=size(bases);
B=reshape(bases(:,:,1:10),[x*y,10]); % Getting 10 Bases in the form of x*y
[bx,by,~]=size(B);
Ident=eye(bx);

% Initilization of the motion flow
dp_x=0;
dp_y=0;

% Applying meshgrid to get the template image
[x_template, y_template] = meshgrid(round(rect(1):rect(3)), round(rect(2):rect(4)));
image_template = interp2(It, x_template, y_template);           %To deal with fractional movement of the template we use interp2()

% Gradient of Image
[dx, dy] = gradient(double(It1));
 
count=0;
%% KLT Steps:

while norm(deltap)>=tol
    if count==50
            break;
    end
        count = count + 1;
        
        % STEP 1:Get the Warped Image with points [0,0]
        [X, Y] = meshgrid((rect(1) : rect(3)) + p(1),(rect(2) : rect(4)) + p(2));
         I = interp2(It1, X,Y);  % This is the warped image I

        % STEP 2:Compute the Error:
         b=image_template-I; %b
         %b=b(:);

        % STEP 3:Warp the gradient of Image with W(x,p)
        Ix = interp2(dx, X, Y);   %A
        Iy = interp2(dy, X, Y);
        %disp(size(Ix));
        
        A=[Ix(:) Iy(:)];
 
        % Calculation of the New A and B 
        A_new=(Ident-B*B')*A;
        b_new=(Ident-B*B')*b(:);
        

        % STEP 4:Compute Jacobian- For pure translation it is Idendity Matrix
        %jacobian=eye(size([Ix(:) Iy(:)]));

        % STEP 5: Compute Steepest Descent Jacobian *Gradient of the Image
        %steepest_descent=1*[Ix(:) Iy(:)];

        % STEP 6: Compute Inverse Hessian H inv
         H = A_new' * A_new;
%          Hinv=inv(H);
        
        % STEP 7:Multiply Steepest Descent with Error 
        %b=steepest_descent*Error(:);
%         deltap= Hinv*A_new'*b_new(:);
           SD=A_new'*b_new;
           deltap=H\SD;

        %STEP 8: compute deltap from H * deltap = b
         %deltap = H \ b;

        %STEP 9: Update parameters
        deltap(1)=round(deltap(1),4);
        deltap(2)=round(deltap(2),4);
        p=p+deltap;
        

end

%Update dp_x and dp_y
dp_x=p(1);
dp_y=p(2);
end

