% Your code here.
for t=1:4
    if t==1
      im='../images/01_list.jpg';
    end
    
    if t==2
      im='../images/02_letters.jpg';
    end
    
    if t==3
      im='../images/03_haiku.jpg';
    end
    
    if t==4
      im='../images/04_deep.jpg';
    end
    
fprintf('\n\nIMAGE 1 %3d',t);    
[lines, bw] = findLetters(im)
pause(3);
end