xbuff=[1 0 -1 -1 0];
ybuff=[0,1,1,-1,-1];
zbuff=[1,1,1,1,1];
A=[1 0 4;0 1 0;0 0 1]
B=[0.866 0.500 0;-0.500 0.866 0;0 0 1]
for k=1:6
    switch(k)
        case 1 
              for i=1:length(xbuff)
                xResult=A*[xbuff(i);ybuff(i);1];
                x1(i)=xResult(1,1);
                y1(i)=xResult(2,1);
              end
                y1(i+1)=0;
                x1(i+1)=5;
                figure('Name','Part A')
                plot(x1,y1,'blue');
                %hold on
             
        case 2
            for i=1:length(xbuff)
                xResult1=(A*B)*[xbuff(i);ybuff(i);1];
                x2(i)=xResult1(1,1);
                y2(i)=xResult1(2,1);
            end
                y2(i+1)=-0.5;
                x2(i+1)=4.866;
               figure('Name','Part B')
               plot(x2,y2,'green');
               %hold on
        case 3
            for i=1:length(xbuff)
                xResult1=(B*A)*[xbuff(i);ybuff(i);1];
                x3(i)=xResult1(1,1);
                y3(i)=xResult1(2,1); 
            end
                y3(i+1)=-2.5;
                x3(i+1)=4.33;
               figure('Name','Part C')
               plot(x3,y3,'black');
               %hold on
        case 4
            for i=1:length(xbuff)
                xResult1=B*[xbuff(i);ybuff(i);1];
                x4(i)=xResult1(1,1);
                y4(i)=xResult1(2,1);
            end
                y4(i+1)=-0.500;
                x4(i+1)=0.8660;
              figure('Name','Part D')
               plot(x4,y4,'red');
               %hold on
        case 5
            
            figure('Name','Part E')
            plot(x2,y2,'black');
            %hold on
        case 6
               figure('Name','Part F')
               plot(x3,y3,'green');
               
    end
    


end
