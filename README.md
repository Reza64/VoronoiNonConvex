# VoronoiNonConvex
This pkg computes the Voronoi region of a continuous non-convex environment

 This function computes the Voronoi region of a occupancy grid map of a continuous non-convex environment

 The main idea is to discretize the input continuous non-convex map to cells and represent this tiles as a grid graph, in which the 
 center of cells considered as the nodes of the graph. 

 The detail of this step can be found in : 
 http://www.mathworks.com/matlabcentral/fileexchange/55519-discretizing--tiling--the-input-map-into-a-grid-graph--and-fast-finding-shortest-path-between-points?s_tid=srchtitle

the advantage of this method is its applicability in non-convex spaces. To define %the sites (center) of Voronoi regions, a GUI asks to set the points at the beginning.

please look for test1.m in the folder as an example 

function dmapval=CreateVoronoi(G,points,showflag)

 inputs

 G: The sparse graph represents the input map. It is obtained by calling the function “G=CreateGridGraph(filename,drate,showflag);”; explained in the above link

 points: sites or the center of Voronoi regions, can be set as input via GUI

showflag: whether show the output or not.
 
outputs

 dmap, mapindx: it is distance map that represent the distance from the sites to their corresponding Voronoi region, mapindex is index of the site in their Voronoi region, thus by using this index map you know that each point belong to which site.

