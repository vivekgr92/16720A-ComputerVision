% your code here
load('aerialseq.mat');

% Total no of frames in Carseq
numOfFrames = size(frames, 3);

% Frames that should be reported
Testframes = [30 60 90 120];

for i=1:numOfFrames
    if i==numOfFrames
        break;
    end
current_frame=frames(:,:,i);
next_frame=frames(:,:,i+1); 
mask = SubtractDominantMotion(current_frame, next_frame);

% convert to RGB scale
RGB = cat(3, mask, mask,zeros(size(mask))); 
image_final=imfuse(next_frame,RGB,'blend');

% To save the results of the  reported frames
j = find(Testframes == i);
    if ~isempty(j)
        %imwrite(image_final,sprintf('./results/AerialSequence%.02d.jpg', i));
        
    end
imshow(image_final);
pause(0.01);
end


