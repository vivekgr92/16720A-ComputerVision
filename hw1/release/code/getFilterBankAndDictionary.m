function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

       
    % TODO Implement your code here
    
    K=200; %100
    alpha= 125; %50;
    filterBank  = createFilterBank();
    totalResponses=[];
    for i=1:length(imPaths)
                temp = imread(imPaths{i});
                [row,col,channel] = size(temp);
                filterResponses = extractFilterResponses(temp,filterBank);
                randpixels=randperm(row*col,alpha);             % Random Pixels 
                [x,y]=ind2sub([row col],randpixels);        % Mapping through 3 Dimensions
                for j=1:alpha
                   randpixelResponse=squeeze(filterResponses(x(j),y(j),:));
                   totalResponses=cat(1,totalResponses,transpose(randpixelResponse));
                      
                end
               
    end
     disp(totalResponses);
      [~, dictionary] = kmeans(totalResponses,K, 'EmptyAction' ,'drop')
      dictionary=transpose(dictionary);
     
end
