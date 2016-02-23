% In this example after converting the occupancy grid map of 
% a continuous non-convex environment into a discretize grid graph 
% 5 points are set as the sites or the center of Voronoi Diagram
% filename, name of the input image
% drate, the rate of iscritization or tiling 
% showflag, it will show the output image if it is set to 1

close all;
clear all;
clc;

% initializing parameters
filename='testmap_883_556.png';
drate = 21;
showflag=1;

% create the grid graph
G=CreateGridGraph(filename,drate,showflag);

% get the source and destination nodes from inputs, 4 points in this example 
if (~showflag)
        imshow(G.mapshow);
end

[p1,p2] = ginput(5);
%convert real position on the map to the corresponding graph node index
points=ConvertPos2Point(G,p1,p2);

[dmap mapindx]=CreateVoronoi(G,points,showflag);
