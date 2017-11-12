function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

    % TODO Implement your code here
%dimensionality = dictionarySize * (4^(layerNum+1) - 1) / 3;


 
 [h,w,c]=size(wordMap);
 %D=zeros(1,H*w);
 D=[];
 E=[];
 F=[];
 totalhist=[];

 

 
 
  % Level 0 ###############################################################
 D=getImageFeatures(wordMap,dictionarySize);
 
  % Level 2 ##############################################################
 cellslice=4;
 hx=mod(h,cellslice);
 wy=mod(w,cellslice);
 
 if hx~=0
     h=h-hx;
 end
 if wy~=0
     w=w-wy;
 end
 
 cellheight=(h/cellslice);
 cellwidth=(w/cellslice);

 for i=1:hx
     wordMap(end,:)=[];      % Reducing the rows and column for wordMap
 end
 
 for j=1:wy
     wordMap(:,end)=[];
 end

 C=mat2cell(wordMap,[cellheight,cellheight,cellheight,cellheight],[cellwidth,cellwidth,cellwidth,cellwidth]);
 for i=1:16
      htemp=getImageFeatures(C{i},dictionarySize);
      %htemp=transpose(htemp)
      F=cat(1,F,htemp)
 end
 disp(F);
 
   % Level 1 ##############################################################
 cellslice=2;
 hx=mod(h,cellslice);
 wy=mod(w,cellslice);
 
 if hx~=0
     h=h-hx;
 end
 if wy~=0
     w=w-wy;
 end
 
 cellheight=(h/cellslice);
 cellwidth=(w/cellslice);
 
 for i=1:hx
     wordMap(end,:)=[];      % Reducing the rows and column for wordMap
 end
 
 for j=1:wy
     wordMap(:,end)=[];
 end
 size(wordMap);

 X=mat2cell(wordMap,[cellheight,cellheight],[cellwidth,cellwidth]);
 for i=1:4
      htemp=getImageFeatures(X{i},dictionarySize);
      %htemp=transpose(htemp)
      E=cat(1,E,htemp);
     
 end
 totalhist= cat(1,(0.5*D),(0.5*E),(0.25*F));
 h=totalhist;


end