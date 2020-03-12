use <experimental/px_polygon.scad>;
use <shape_starburst.scad>;

points = [
    for(pt = shape_starburst(20, 10, 6)) 
        [round(pt[0]), round(pt[1])]
];

for(p = px_polygon(points)) {
    translate(p) 
    linear_extrude(1, scale = 0.5) 
        square(1, center = true);  
}