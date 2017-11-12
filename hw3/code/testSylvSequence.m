% your code here
load('sylvseq.mat');
load('sylvbases.mat');

% Total no of frames in Svlbases
numOfFrames = size(frames, 3);

% Initialization n*4
svlrects = zeros(numOfFrames, 4);

% Initialize position of the car that we want to track
rect = [102, 62, 156, 108]; %[x y x y] of the rectangle
rect_new=[102, 62, 156, 108];

% Frames that should be reported
Testframes = [1 200 300 350 400];

%% Real Time tracking in a number of frames
for i=1:numOfFrames
    % Condition for not exceeding the no of frames for the next_frames
    if i==numOfFrames
        break;
    end
current_frame=frames(:,:,i);
next_frame=frames(:,:,i+1);
%% With LK Basis
[dp_x,dp_y] = LucasKanadeBasis(current_frame, next_frame, rect,bases);
%Adding the delta P to the rectangle box
rect=rect+[dp_x dp_y dp_x dp_y];
%Calculating the width and height of the rectangle to be drawn
width=rect(3)-rect(1);
height=rect(4)-rect(2);
pos=[rect(1) rect(2) width height];

%% With LK
[dp_x_new,dp_y_new] = LucasKanade(current_frame, next_frame, rect_new);
%Adding the delta P to the rectangle box
rect_new=rect_new+[dp_x_new dp_y_new dp_x_new dp_y_new];
%Calculating the width and height of the rectangle to be drawn
width=rect_new(3)-rect_new(1);
height=rect_new(4)-rect_new(2);
pos_new=[rect_new(1) rect_new(2) width height];

% Drawing the Rectangle
imshow(current_frame);
hold on
rectangle('Position',pos,'LineWidth',2,'EdgeColor','y');
rectangle('Position',pos_new,'LineWidth',2,'EdgeColor','r');
hold off

% Check for the reported frames and saving it to a file
j = find(Testframes == i);
    if ~isempty(j)
        %current_frame=insertShape(current_frame,'Rectangle',pos,'LineWidth',5);
        %imwrite(current_frame,sprintf('./results/SylvSequence%.02d.jpg', i));
        
    end
  
% Updating the new rectangle coordinates to carseqrects
svlrects(i, :) = rect;

pause(0.01);

end

save('results/sylvseqrects.mat','svlrects');





% your code here