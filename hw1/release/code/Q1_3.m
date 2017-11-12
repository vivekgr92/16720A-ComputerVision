img=imread('E:\EDUCATION\MRSD\Computer Vision\hw1\release\data\auditorium\sun_ahcmaddzrcfxzuuz.jpg');
imshow(img);
title('Original');
[filterBank] = createFilterBank()
%[filterBank, dictionary] = getFilterBankAndDictionary(imPaths);

computeDictionary();
wordMap = getVisualWords(img, filterBank, dictionary);