function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs: 
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W x H x N*3 matrix of filter responses


% TODO Implement your code here
 [M,N,numberofChannels] = size(img);
 x=0;

 
 if numberofChannels~=3
     img=repmat(img,[1,1,3])
 end
  
 filterResponses=[];
 
  I= RGB2Lab(img);
   for i=1:20 
         I3=imfilter(I,filterBank{i},'replicate'); % Boundary Padding
         %figure, imshow(I3), title('Figure')        % display individual img
         filterResponses=cat(3,filterResponses,I3);
         %filterResponses=cat(4,filterResponses,I3);      Use this if montage is used                                     
  
         
   end
      
    
      
    
    %montage(filterResponses,'Size', [4 5]);
    
end
