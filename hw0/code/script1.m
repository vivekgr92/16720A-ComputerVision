% Problem 1: Image Alignment

%% 1. Load images (all 3 channels)
red = load('red.mat');  % Red channel
green = load('green.mat');  % Green channel
blue = load('blue.mat');  % Blue channel
%imshow(green.green);
C=cat(3,red.red,green.green,blue.blue);
imshow(C)

[x1,y1,z1] = size(red.red);
redshift=[]
temp=sum(sum(red.red(:,:)-blue.blue(:,:)).^2);
temp1=sum(sum(green.green(:,:)-blue.blue(:,:)).^2);
temp2=temp;
temp3=temp1;  
for x=1:2
  for n=-30:30
     redshift=circshift(red.red,n,x); 
     greenshift=circshift(green.green,n,x);
    if(x==1)
      if sum(sum(redshift(:,:)-blue.blue(:,:)).^2)< temp
        newredrow=n;
        temp=sum(sum(redshift(:,:)-blue.blue(:,:)).^2);
      end
      elseif(x==2)
       if sum(sum(redshift(:,:)-blue.blue(:,:)).^2)< temp1
         newredcol=n;
         temp1=sum(sum(redshift(:,:)-blue.blue(:,:)).^2);
       end
    end
    %%%%% DOING IT FOR GREEN
   if(x==1)
     if sum(sum(greenshift(:,:)-blue.blue(:,:)).^2)< temp2
        newgreenrow=n;
        temp2=sum(sum(greenshift(:,:)-blue.blue(:,:)).^2);
     end
      elseif(x==2)
       if sum(sum(greenshift(:,:)-blue.blue(:,:)).^2)< temp3
        newgreencol=n;
        temp3=sum(sum(greenshift(:,:)-blue.blue(:,:)).^2);
      end
     end
  end
end
 

shiftedRedrow=circshift(red.red,newredrow,1);
shiftedGreenrow=circshift(green.green,newgreenrow,1);

shiftedRedCol=circshift(shiftedRedrow,newredcol,2);
shiftedGreenCol=circshift(shiftedGreenrow,newgreencol,2);

colorRGB=cat(3,shiftedRedCol,shiftedGreenCol,blue.blue);
%1imshow(colorRGB);

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
%rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
