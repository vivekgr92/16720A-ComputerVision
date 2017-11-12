function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% INPUTS
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
%
% OUTPUTS
% bestH - homography model with the most inliers found during RANSAC

%% Initialization and declaration of variables
x1=[];
x2=[];
p1=[];
p2=[];
newp1=[];
newp2=[];
y1=[];
y2=[];
inliers_hmatrix=[];
rest_point_inlocs1=[];
rest_point_inlocs2=[];
calculatedlocs=zeros(3,1);
ssd=zeros(2,1);
total=length(matches);
inliers_num=0;
max_inliers = 0;
bestinliers = [];

%% Main Interation for RANSAC
for i=1:nIter
random_points=randperm(total,4);               % Random 4 points are taken from the locs1 and locs2 corresponding to matches index
        for j=1:4
        in=matches(random_points(j),:);
        x1=locs1(matches(random_points(j)),:);
        in2=matches(random_points(j),end);
        x2=locs2(in2,:);
        x1=x1';
        x2=x2';
        p1=cat(2,p1,x1(1:end-1));
        p2=cat(2,p2,x2(1:end-1));
       % p1(:,:)=locs1(matches(random_points(j)),:);
       % p2=locs2(matches(random_points(j)),:);
        end
Hmatrix=computeH(p1,p2);                      % Compute the Hmatrix for the sample points taken above

%% Match the compute H with the rest of the points in the locs corresponding to matches
curr_inliers = [];
    for k=1:length(matches)                  
        y1=locs1(matches(k),:);
        y2=locs2(matches(k,2),:);
        y1=y1';
        y2=y2';
        rest_point_inlocs1=cat(2,rest_point_inlocs1,y1(1:end-1));
        rest_point_inlocs2=cat(2,rest_point_inlocs2,y2(1:end-1));
        rest_point_inlocs1(end+1,:)=1;
        rest_point_inlocs2(end+1,:)=1;
        
        %rest=rest_point_inlocs2(:,k);                      %point 2
        calculatedlocs=Hmatrix * rest_point_inlocs2;         %rest
        calculatedlocs=calculatedlocs./(calculatedlocs(end,:));  
        
 %% Take the Eucledean distance sqrt((x-x1)^2+(y-y1)2)
        
        error1=sqrt((rest_point_inlocs1(1,:)-calculatedlocs(1,:))^2 + (rest_point_inlocs1(2,:)-calculatedlocs(2,:))^2);
       % error1=rest_point_inlocs1(1:end-1,:),calculatedlocs(1:end-1,:)
        if error1<tol                                        % Take the error tolerance of 5
            inliers_num=inliers_num+1;                       % Counting the no of inliers
        % Add to curr_inliers
            curr_inliers=cat(1,curr_inliers,matches(k,:));   % index of matches
        end        
        rest_point_inlocs1=[];
        rest_point_inlocs2=[];
        y1=[];
        y2=[];
    end
    
    if inliers_num > max_inliers                             
        max_inliers = inliers_num;
        bestinliers = curr_inliers;
    end        
disp(inliers_num)
inliers_num=0;
end

%% % Extracting the locs points from the index of the matches
for l=1:length(bestinliers)                             
        in=bestinliers(l);
        x1=locs1(in,:);
        in2=bestinliers(l,end);
        x2=locs2(in2,:);
        x1=x1';
        x2=x2';
        
        newp1=cat(2,newp1,x1(1:end-1));                 
        newp2=cat(2,newp2,x2(1:end-1));
end
bestH=computeH(newp1,newp2);                             % Computing the new H
end
