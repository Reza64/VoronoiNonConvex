function points=ConvertPos2Point(G,x,y)
imgcol=size(G.map,2);
imgrow=size(G.map,1);
row=round(imgrow/G.drate); 
col=round(imgcol/G.drate); 
c=1;
for i=1:size(x,1)
    x1=uint32(y(i)/G.drate);
    y1=uint32(x(i)/G.drate);
    if ( (x1>=row ) || ( y1>=col) || (x1<1 ) || ( y1<1) || G.map(uint32(y(i)),uint32(x(i)))==0)
        fprintf('points are out of range!\n');
        continue;
    end
        points(c)=(y1+1)+(col*(x1));
        c=c+1;
end
