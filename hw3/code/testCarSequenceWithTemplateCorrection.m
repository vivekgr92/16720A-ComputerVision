% your code here
load('carseq.mat');
%imshow(frames(:, :, 1));
%It=frames(:, :, 1);
%It1=frames(:, :, 2);



% Total no of frames in Carseq
numOfFrames = size(frames, 3);

% Initialization n*4
carseqrects_wcrt = zeros(numOfFrames, 4);

% Initialize position of the car that we want to track
rect = [60, 117, 146, 152]; %[x y x y] of the rectangle
rect0 = [60, 117, 146, 152];
%rect=rect';

% Frames that should be reported
Testframes = [1 100 200 300 400];

%% Real Time tracking in a number of frames
for i=1:numOfFrames
% Condition for not exceeding the no of frames for the next_frames
    if i==numOfFrames
        break;
    end

%% Template Correction Routine    
original_frame=frames(:,:,1);
current_frame=frames(:,:,i);
next_frame=frames(:,:,i+1);
% LK 1
[dp_x,dp_y] = LucasKanade(current_frame, next_frame, rect);

%Adding the delta P to the rectangle box
rect=rect+[dp_x dp_y dp_x dp_y];

% Image Translation og original image to the current frame
translation=[rect(1)-rect0(1) rect(2)-rect0(2)];
original_frame_1=imtranslate(original_frame,translation);

%LK 2  for eliminating the error accumulated in previous frames
[U,V]=LucasKanade(original_frame_1, next_frame, rect);
rect=rect+[U V U V];

%Calculating the width and height of the rectangle to be drawn
width=rect(3)-rect(1);
height=rect(4)-rect(2);
pos=[rect(1) rect(2) width height];

% Drawing the Rectangle
imshow(current_frame);
hold on
rectangle('Position',pos,'LineWidth',2,'EdgeColor','y');
hold off

% Check for the reported frames and saving it to a file
j = find(Testframes == i);
    if ~isempty(j)
        %current_frame=insertShape(current_frame,'Rectangle',pos,'LineWidth',5);
        %imwrite(current_frame,sprintf('Images_frame_corrected%.02d.jpg', i));
        
    end
  


% Updating the new rectangle coordinates to carseqrects
carseqrects_wcrt(i, :) = rect;

pause(0.01);

end

save('results/carseqrects-wcrt','carseqrects_wcrt');





