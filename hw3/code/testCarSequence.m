% your code here
load('carseq.mat');
%imshow(frames(:, :, 1));
%It=frames(:, :, 1);
%It1=frames(:, :, 2);

% Total no of frames in Carseq
numOfFrames = size(frames, 3);

% Initialization n*4
carseqrects = zeros(numOfFrames, 4);

% Initialize position of the car that we want to track
rect = [60, 117, 146, 152]; %[x y x y] of the rectangle
%rect=rect';

% Frames that should be reported
Testframes = [1 100 200 300 400];

%% Real Time tracking in a number of frames
for i=1:numOfFrames
% Condition for not exceeding the no of frames for the next_frames
    if i==numOfFrames
        break;
    end
current_frame=frames(:,:,i);
next_frame=frames(:,:,i+1);
[dp_x,dp_y] = LucasKanade(current_frame, next_frame, rect);

%Adding the delta P to the rectangle box
rect=rect+[dp_x dp_y dp_x dp_y];
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
        %imwrite(current_frame,sprintf('./results/Images_frame%.02d.jpg', i));
        
    end
  


% Updating the new rectangle coordinates to carseqrects
carseqrects(i, :) = rect;

pause(0.01);

end

save('results/carseqrects.mat','carseqrects');





