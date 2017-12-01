% Your code here.
%fname=[10]

for t=1:4
    if t==1
      fname='../images/01_list.jpg';
    end
    
    if t==2
      fname='../images/02_letters.jpg';
    end
    
    if t==3
      fname='../images/03_haiku.jpg';
    end
    
    if t==4
      fname='../images/04_deep.jpg';
    end
    
fprintf('\n\nIMAGE 1 %3d',t);    
[text] = extractImageText(fname)

pause(5);
end