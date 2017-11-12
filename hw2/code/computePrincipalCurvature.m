function PrincipalCurvature = computePrincipalCurvature(DoGPyramid)
%%Edge Suppression
% Takes in DoGPyramid generated in createDoGPyramid and returns
% PrincipalCurvature,a matrix of the same size where each point contains the
% curvature ratio R for the corre-sponding point in the DoG pyramid
%
% INPUTS
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
%
% OUTPUTS
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix where each 
%                      point contains the curvature ratio R for the 
%                      corresponding point in the DoG pyramid

%% Taking the gradient on the pixels of the image
[Dx,Dy]=gradient(DoGPyramid);
[Dxx,Dxy]=gradient(Dx);
[Dyx,Dyy]=gradient(Dy);

%% calculating the Hessian matrix 2*2
Hessmatrix=[Dxx,Dxy;Dyx,Dyy];      
%size(Hessmatrix)

%% Calculating the Principal Curvature on all the levels of Dog Pyramid
for i=1:5           
    
THsqr(:,:,i)=Dxx(:,:,i)+Dyy(:,:,i);                                   %%  Dxx.Dyy-(Dxy)^2
DetH(:,:,i)=Dxx(:,:,i).*Dyy(:,:,i)-(Dxy(:,:,i).*Dxy(:,:,i));

PrincipalCurvature(:,:,i)=(THsqr(:,:,i).*THsqr(:,:,i))./DetH(:,:,i);   %% Trace^2/ Det(H)

end


