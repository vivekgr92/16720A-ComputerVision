function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

if size(im,3)==3 % RGB image
  im=rgb2gray(im);
end

%% Blur
sigma=1.5;
im = imgaussfilt(im,sigma);

%% Binarization
threshold = graythresh(im);
im =~imbinarize(im,threshold);
bw=bwareaopen(im,120);



%% Find connected components
%[L Ne]=bwlabel(bw);
figure, imshow(~bw);
thresh = 250;
cc = regionprops(bw, 'BoundingBox','Area','centroid' );
centroids = cat(1, cc.Centroid);
arraymat = [];
for k = 1 : length(cc)
    BoundingBox = cc(k).BoundingBox;
    hold on
    if(cc(k).Area > thresh)
        rectangle('Position', [BoundingBox(1),BoundingBox(2),BoundingBox(3),BoundingBox(4)],...
        'EdgeColor','r','LineWidth',2 )
        text(BoundingBox(:,1), BoundingBox(:,2), sprintf('%d', k));
        plot(centroids(k,1),centroids(k,2), 'b*','LineWidth',5)
        arraymat = cat(1,arraymat,[centroids(k,2),centroids(k,1),BoundingBox(1),BoundingBox(2),BoundingBox(3),BoundingBox(4)]);
    end
end
arraymat = sortrows(arraymat,1);
lines = {};

%% Inserting into a line
for i=1:size(arraymat,1)
   if i==1 || (abs(arraymat(i,1)-arraymat(i-1,1))>100)
       new_arr = [arraymat(i,3),arraymat(i,4),arraymat(i,5)+arraymat(i,3),arraymat(i,6)+arraymat(i,4)];
       if i ~=1
       lines{end} = sortrows(lines{end},1);
       end
       lines{max(size(lines))+1} = new_arr;
   else
       lines{end} = cat(1,lines{end}, [arraymat(i,3),arraymat(i,4),arraymat(i,5)+arraymat(i,3),arraymat(i,6)+arraymat(i,4)]);
   end
end

assert(size(lines{1},2) == 4,'each matrix entry should have size Lx4');
assert(size(lines{end},2) == 4,'each matrix entry should have size Lx4');
lineSortcheck = lines{1};
assert(issorted(lineSortcheck(:,1)) | issorted(lineSortcheck(end:-1:1,1)),'Matrix should be sorted in x1');

end