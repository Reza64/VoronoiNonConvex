function [dmapval mapindx]=CreateVoronoi(G,points,showflag)

% This function computes the Voronoi region of a occupancy grid
%  map of a continuous non-convex environment
% The main idea is to discretize the input continuous non-convex map to cells 
% and represent this tiles as a grid graph, in which the 
% center of cells considered as the nodes of the graph. 
% The detail of this step can be found in : 
% http://www.mathworks.com/matlabcentral/fileexchange/55519-discretizing--
% tiling--the-input-map-into-a-grid-graph--and-fast-finding-shortest-path-between-points?s_tid=srchtitle

%the advantage of this method is its applicability in
% non-convex spaces. To define %the sites (center) of 
% Voronoi regions, a GUI asks to set the points at the beginning.
% please look for test1.m in the folder as an example 

%function dmapval=CreateVoronoi(G,points,showflag)
% inputs
% G: The sparse graph represents the input map. It 
% is obtained by calling the function 
% “G=CreateGridGraph(filename,drate,showflag);”; explained in the above link
% points: sites or the center of Voronoi regions, can be set as input via GUI
% showflag: whether show the output or not.
 
%outputs
% dmap, mapindx: it is distance map that represent
% the distance from the sites to their corresponding 
% Voronoi region, mapindex is index of the site in their 
% Voronoi region, thus by using this index map you know that each point belong to which site.
%%

    if (nargin<1 || size(points,2) ==0)
        disp('The size of the input vectors are mismatch!');
        return
    end
    %global variables 
    global drate;
    global map;
    global color;
    
    % initializing variables
    drate=G.drate;
    color=rand(10,3);
    imgcol=size(G.map,2);
    imgrow=size(G.map,1);
    row=round(imgrow/drate); 
    col=round(imgcol/drate); 
    img=G.mapshow;
    if (size(img,3)>1)
        img=rgb2gray(img);
    end
    map=img;
    if (showflag)
        figure;
        imshow(map);
        hold on;
    end
    
    %compute distance to all of the points in the map
    for i=1:size(points,2)    
        [dist,path,pred] = graphshortestpath(G.g,points(i));
        mmap(i).map=vec2mat(dist,col);
        rrow=size(mmap(1).map,1);
        difrow=row-rrow;
        mmap(i).map(rrow:rrow+difrow,:)=inf;
    end
    
    %% show output
    Vmap = repmat(img,[1 1 3]);
    Vmap = cat(3,img,img,img);
    mapindx=zeros();
    for k=1:row
        for j=1:col
            temp=[];
            for kk=1:size(points,2)    
                temp=[temp mmap(kk).map(k,j)];
            end
            [val indx]=min(temp);
            dmapval(k,j)=val;           
            if (isinf(val) || val==0 )  % obstacles
                % do nothing
                 mapindx(k,j)=0;
            else
                Vmap=FillMap(Vmap,k-1,j-1,indx);
                 mapindx(k,j)=indx;
            end
        end
    end
    if (showflag)
        imshow(Vmap);
        hold on;
        for kk=1:size(points,2)    
            plot(G.points(2,points(kk))*drate+(drate/2),G.points(1,points(kk))*drate+(drate/2) , '--ys',...
            'LineWidth',2,...
            'MarkerEdgeColor','k',...
            'MarkerFaceColor','r',...
            'MarkerSize',12);
        end
    end