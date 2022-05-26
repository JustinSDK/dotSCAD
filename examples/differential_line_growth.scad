use <shape_circle.scad>;
use <experimental/differential_line_growth.scad>;
    
$fn = 24;
r = 20;
times = 50;
thickness = 2;
node_option = [
    0.5,    // maxForce 
    0.7,    // maxSpeed
    12,     // separationDistance
    1.5,    // separationCohesionRatio 
    10      // maxEdgeLength
];

init_shape = shape_circle(r);
linear_extrude(thickness)
    polygon(differential_line_growth(init_shape, node_option, times));
