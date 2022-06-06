use <voronoi/vrn2_space.scad>
use <bend_extrude.scad>
use <arc.scad>

size = [300, 120];
grid_w = 30;
thickness = 2;
spacing = 3;
seed = 5;
$fn = 24;

color("black")
bend_extrude(size, thickness = thickness, angle = 360) 
    vrn2_space(size, grid_w, seed, spacing);

r = size[0] / (2 * PI);
linear_extrude(size[1])
    arc(radius = r - thickness, angle = [0, 360], width = thickness / 2);

linear_extrude(thickness)    
    circle(r);    