function [dp_x,dp_y] = LucasKanade(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [dp_x, dp_y] in the x- and y-directions.

%% Initilization of parameters
tol = 0.1;
deltap = 2 * [tol tol]';
p=[0,0]; % initial point
It = im2double(It);
It1=im2double(It1);

% Initilization of the motion flow
dp_x=0;
dp_y=0;

% Applying meshgrid to get the template image
[x_template, y_template] = meshgrid(rect(1):rect(3), rect(2):rect(4));
image_template = interp2(It, x_template, y_template);           %To deal with fractional movement of the template we use interp2()
%image_template=It(y_template,x_template);

% Gradient of Image
[dx, dy] = gradient(double(It1));
 

%% KLT Steps:

while norm(deltap)>=tol

        % STEP 1:Get the Warped Image with points [0,0]
        [X, Y] = meshgrid((rect(1) : rect(3)) + p(1),(rect(2) : rect(4)) + p(2));
         I = interp2(It1, X, Y);  % This is the warped image I

        % STEP 2:Compute the Error:
         Error=image_template-I;

        % STEP 3:Warp the gradient of Image with W(x,p)
        Ix = interp2(dx, X, Y);
        Iy = interp2(dy, X, Y);

        % STEP 4:Compute Jacobian- For pure translation it is Idendity Matrix
        jacobian=eye(size([Ix(:) Iy(:)]));

        % STEP 5: Compute Steepest Descent Jacobian *Gradient of the Image
        steepest_descent=1*[Ix(:) Iy(:)];

        % STEP 6: Compute Inverse Hessian H inv
         H = [Ix(:) Iy(:)]' * [Ix(:) Iy(:)];
         Hinv=inv(H);
        
        % STEP 7:Multiply Steepest Descent with Error 
        %b=steepest_descent*Error(:);
        deltap= Hinv*[Ix(:) Iy(:)]'*Error(:);

        %STEP 8: compute deltap from H * deltap = b
         %deltap = H \ b;

        %STEP 9: Update parameters
        p=p+deltap;

end

%Update dp_x and dp_y
dp_x=p(1);
dp_y=p(2);
end

 


 
 
 
 