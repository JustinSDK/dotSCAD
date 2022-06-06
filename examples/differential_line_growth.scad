use <shape_circle.scad>
use <experimental/differential_line_growth.scad>
use <midpt_smooth.scad>

$fn = 24;
r = 10;
times = 80;
thickness = 2;
smooth = true;
smooth_times = 2;
node_option = [
    0.4,    // maxForce 
    0.5,    // maxSpeed
    5,      // separationDistance
    1.2,    // separationCohesionRatio 
    4       // maxEdgeLength
];

init_shape = shape_circle(r);
poly = differential_line_growth(init_shape, node_option, times);

linear_extrude(thickness)
    polygon(
        smooth ? midpt_smooth(poly, smooth_times, true) : poly 
    );
