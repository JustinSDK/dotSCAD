use <util/rand.scad>
use <experimental/circle_packing.scad>

size = [200, 100];
min_radius = 1;
point_numbers = 100;
    
points = [
    for(i = [0:point_numbers - 1])
    [rand(0, size.x), rand(0, size.y)]
]; 

circles = circle_packing(points, min_radius);
mr = max([for(c = circles) c[1]]);
translate([0, 0, mr]) 
    for(c = circles) {
        translate(c[0])
            sphere(c[1], $fn = 48);
    }

for(c = circles) {
    translate(c[0])
    linear_extrude(mr) 
        circle(c[1]/ 3, $fn = 48);
}
linear_extrude(1) square(size);
