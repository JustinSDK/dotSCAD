use <shape_circle.scad>;
use <midpt_smooth.scad>;
use <polyline_join.scad>;
use <polyhedra/icosahedron.scad>;
use <experimental/differential_line_growth.scad>;
use <experimental/ptf_c2sphere.scad>;

$fn = 24;
r = 10;
times = 50;
line_r = 2;
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
smoothed = smooth ? midpt_smooth(poly, smooth_times, true) : poly;

sphere_r = max(max(smoothed));
polyline_join([for(p = [each smoothed, smoothed[0]]) ptf_c2sphere(p, sphere_r)])
    icosahedron(line_r);
