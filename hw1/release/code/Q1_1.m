img=imread('E:\EDUCATION\MRSD\Computer Vision\hw1\release\data\auditorium\sun_ahcmaddzrcfxzuuz.jpg');
imshow(img);
title('Original');
[filterBank] = createFilterBank()
[filterResponses]=extractFilterResponses(img, filterBank)
%figure,imshow(filterResponses(1,:,:,:)),title('Montage')


% Q 1.2

%[filterBank, dictionary] = getFilterBankAndDictionary(imagenames)
