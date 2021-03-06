function [compareA, compareB] = makeTestPattern(patchWidth, nbits) 
%%Creates Test Pattern for BRIEF
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and
% save the results in testPattern.mat.
%
% INPUTS
% patchWidth - the width of the image patch (usually 9)
% nbits      - the number of tests n in the BRIEF descriptor
%
% OUTPUTS
% compareA and compareB - LINEAR indices into the patchWidth x patchWidth image 
%                         patch and are each nbits x 1 vectors. 

   totalelements=patchWidth*patchWidth;
   
   compareA=[];
   compareB=[];
   compareA=randi([1 totalelements],nbits,1);
   compareB=randi([1 totalelements],nbits,1);
   save('./data/testPattern.mat');
   