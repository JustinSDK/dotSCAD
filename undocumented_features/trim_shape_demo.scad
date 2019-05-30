include <hull_polyline2d.scad>;
include <trim_shape.scad>;
include <shape_taiwan.scad>;
include <bijection_offset.scad>;
include <midpt_smooth.scad>;

taiwan = shape_taiwan(50);
offseted = bijection_offset(taiwan, -2);
trimmed = trim_shape(offseted, 3, len(offseted) - 6);
smoothed = midpt_smooth(trimmed, 3);

#hull_polyline2d(taiwan, .1); 
%translate([25, 0, 0]) hull_polyline2d(offseted, .2);
hull_polyline2d(smoothed, .1); 
