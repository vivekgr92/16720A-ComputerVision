function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

    % TODO Implement your code here
    
  filterResponses=[];
  dictionary=transpose(dictionary);
  
  

  [row, col, channel]=size(img);
  
  %disp(wordMap);
  %wordMap=zeros((row*col),1)         
  filterResponses = extractFilterResponses(img,filterBank);
  size(filterResponses)
  filterResponses=reshape(filterResponses,row*col,60);  %% change into columns
  size(filterResponses)
  [~,wordMap]=pdist2(dictionary,filterResponses,'euclidean','smallest',1);
  size(wordMap)
  wordMap=reshape(wordMap,row,col);
  %size(wordMap)
  imagesc(wordMap);
  
  %colormap(wordMap);
  
  
  
  
  
  
  
  

end
