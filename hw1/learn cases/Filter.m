img=imread('panda.jpg');
imshow(img);
grayimg=rgb2gray(img);
imshow(grayimg)

hsize=31;
sigma=1;
h=fspecial('gaussian',hsize,sigma);

surf(h)
colormap summer         % Not yet Know on how to use color map

imagesc(h);

outim=imfilter(grayimg,h);
imshow(outim);
