include <shape_taiwan.scad>;
include <in_shape.scad>;

/*    
points = [
   [10, 0],
   [10, 10],
   [-10, 10], 
   [-10, -10]
];*/


points = shape_taiwan(30); 
%polygon(points);
pt = [-10, 9];

n = 200;
xs = rands(-10, 10, n);
ys = rands(-18, 18, n);

pts = [
    for(i = [0:n]) 
        let(p = [xs[i], ys[i]]) 
        if(in_shape(points, p, true))
        p
    ]; 

for(p = pts) {
    translate(p) circle(.2); 
}

    