function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix

%% Initilization of parameters
tol = 0.3;
deltap = [2 2];
p=zeros(6, 1); %initial point
It = im2double(It);
It1=im2double(It1);

% Initilization of the motion flow
dp_x=0;
dp_y=0;

 % Define the M matrix for affine transformation
         M = [1 + p(1),    p(3),         p(5);
         p(2),        1 + p(4),     p(6);
         0,           0,            1       ];
     
% Applying meshgrid to get all points from the image
[X, Y] = meshgrid(1 : size(It, 2), 1 : size(It, 1));
%tform = affine2d(M); % last column is [0; 0; 1]
%template = imwarp(It, tform); % Image warped


Image_points = [X(:)'; Y(:)'; ones(size(X(:)'))];  %% to be in the form of  [x y z 1]



% Gradient of Image
[It1x, It1y] = gradient(double(It1));
 

%% KLT Steps:

count = 0;
while norm(deltap)>=tol
        if count==100
            break;
        end
        count = count + 1
        %To find I(W(x;p))
        I = M*Image_points;
      	Ix = I(1,:);
        Iy = I(2,:);
      	IWxp = interp2 (It1, Ix, Iy, 'bilinear');
      	IWxp(isnan(IWxp)) = 0;
        IWxp = reshape(IWxp, size(It));

        %STEP 2:Compute the Error:s
        %disp([size(template), size(IWxp)])
         Error = It - IWxp;   %% It as template ************

       % STEP 5: Compute Steepest Descent Jacobian *Gradient of the Image
    	[gradientX gradientY] = gradient(It1);   %%% It1  Clean the Gradient Nan
        %gradientX(isNan)=0;
        
        steepest_descent =[X(:).*gradientX(:), X(:).*gradientY(:), Y(:).*gradientX(:), Y(:).*gradientY(:), gradientX(:), gradientY(:)];
        
        % STEP 6: Compute Inverse Hessian H inv
         H = steepest_descent' * steepest_descent;
         Hinv=inv(H);
        
        % STEP 7:Multiply Steepest Descent with Error 
        %b=steepest_descent*Error(:);
        deltap= Hinv*steepest_descent'*Error(:);

        %STEP 8: compute deltap from H * deltap = b
         %deltap = H \ b;

        %STEP 9: Update parameters
         M = M + [reshape(deltap, 2, 3); zeros(1,3)];
         %norm(deltap)

end


end

