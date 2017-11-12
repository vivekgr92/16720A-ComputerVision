function H2to1 = computeH(p1,p2)
% INPUTS:
% p1 and p2 - Each are size (2 x N) matrices of corresponding (x, y)'  
%             coordinates between two images
%
% OUTPUTS:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear 
%         equation

%% Extracting points: 
x = p1(1, :);        %% In the form p1=[x1,x2 ,x3,x4]    similar for point 2    
y = p1(2,:);         %%                 [y1,y2,y3,y4]

u = p2(1,:); 
v = p2(2,:);

xu=(p1(1,:)').*(p2(1,:)'); % x1u1....
xv=(p1(1,:)').*(p2(2,:)'); % x1v1....
yu=(p1(2,:)').*(p2(1,:)'); % y1u1....
yv=(p1(2,:)').*(p2(2,:)'); % y1v1....

n = size(p2, 2);
rows0 = zeros(n,3);
rowsXY = -[u; v; ones(1,n)]';

cat1=[rowsXY;rows0];
cat2=[rows0;rowsXY];      %% Concatenating -u -v -1  0  0  0 u1x1 u1y1 x1
                           %                 0  0  0 -u -v -1 v1x1 v1y1 y1
             
cat3=[xu xv x';yu yv y'];

%% SVD for least square approximation
Amatrix=[cat1 cat2 cat3];  
[~, ~, V] = svd(Amatrix'*Amatrix); %% transpose for making the matrix square  Taking SVD for least square approximation
vnorm=normc(V(:,9));               %% Normalizing the column vector

v = (reshape(vnorm, 3, 3)).';   %%   element in order you need to transpose

H2to1=v;         

end

