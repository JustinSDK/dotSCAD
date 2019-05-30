include <hull_polyline2d.scad>;
include <shape_taiwan.scad>;
include <bijection_offset.scad>;
include <midpt_smooth.scad>;


    
taiwan = shape_taiwan(100, .5);  
sm = midpt_smooth(taiwan, 1, true);

*translate([10, 0, 0]) hull_polyline2d(shape_taiwan(100), .1); 
translate([10, 0, 0]) hull_polyline2d(sm, .1);

echo(len(taiwan));