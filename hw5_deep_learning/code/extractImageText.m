function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.
im = imread(fname);
[lines,bw] = findLetters(im);
image = imcomplement(bw);
load('../data/nist36_model.mat', 'W', 'b');
text = [];
for i =1:max(size(lines))
    G = lines{i};
    
    %% Image Extraction
    for j= 1:max(size(G))
         x_topleft = G(j,1);
         y_topleft = G(j,2);
         width = G(j,3) - x_topleft;
         height = G(j,4) - y_topleft;
         rect=[x_topleft y_topleft width height];
       
        
        %% Cropping
        I = imcrop(image,rect);
        I = padarray(I,[10 10],1,'both');
        I = imresize(I,[32 32]);
        %figure(2), imshow(I);
        I1 = I;
        data = I1(:)';
        [outputs] = Classify(W, b, data);
        [~,index] = max(outputs,[],2);
        if index < 27
            text = cat(2,text,char(index+64));
        else
            disp(index-27);
            text = cat(2,text,int2str(index-27));
        end
        
    end
    text=cat(2,text,char(' '));
    
end