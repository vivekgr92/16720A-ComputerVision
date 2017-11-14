
[coordsIM1, coordsIM2] = epipolarMatchGUI(img1, img2, F)
%[ x2, y2 ]=epipolarCorrespondence( img1, img2, F, x1, y1 )

save('./data/q4_1.mat','F','coordsIM1','coordsIM2'); 