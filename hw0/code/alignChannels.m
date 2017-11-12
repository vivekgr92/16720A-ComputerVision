function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here
ssd=0;
for n=-30:30
    redshift=circshift(red,n,1);
    %greenshift=circshift(green,n,1);

    ssd = redshift(:,:)-blue(:,:).^2
    fprintf("%x",ssd);
     
end