function   Vmap=FillMap(Vmap,i,j,Val)
global color;
global drate;
global map;

imgcol=size(map,2);
imgrow=size(map,1);
i=(i)*drate+floor(drate/2)+1;
j=(j)*drate+floor(drate/2)+1;

cubsize=floor(drate/3);
% the loop to fill the points
for k=-1*cubsize:cubsize
    for l=-1*cubsize:cubsize
        if ((i+k>=imgrow ) || ( j+l>=imgcol) || (i+k<=0) || (j+l<=0))
            continue;     
        end
        Vmap(i+k,j+l,:)=color(Val,:)*255;
   end%end for k cubesize check if it's obstacle
end

end
