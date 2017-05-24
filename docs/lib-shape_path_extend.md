# shape_path_extend

It extends a 2D stroke along a path to create a 2D shape. This module is suitable for a path created by a continuous function. The returned points can be used with xxx_extrude modules of dotSCAD. The shape points can be also used with the built-in polygon module.

When using this module, you should use points to represent the 2D stroke. 

It depends on the `rotate_p` function. Remember to include "rotate_p.scad" and "polytransversals.scad".

## Parameters

- `stroke_pts` : A list of points represent a stroke. See the example below.
- `path_pts` : A list of points represent the path.
- `scale` : Scales the 2D shape by this value over the length of the extrusion.
- `closed` : If the first point and the last point of `path_pts` has the same coordinate, setting `closed` to `true` will connect them automatically.

## Examples

	include <rotate_p.scad>;
	include <shape_path_extend.scad>;
	include <circle_path.scad>;
	include <archimedean_spiral.scad>;
	
	$fn = 96;
	
	stroke1 = [[-5, 2.5], [-2.5, 0], [0, 2.5], [2.5, 0], [5, 2.5]];
	path_pts1 = circle_path(50, 60);
    polygon(
	    shape_path_extend(stroke1, path_pts1)
    );
    
	
	stroke2 = [[-4, 0], [0, 4], [4, 0]];
	pts_angles = archimedean_spiral(
	    arm_distance = 17,
	    init_angle = 180,
	    point_distance = 5,
	    num_of_points = 85 
	); 
	
	translate([120, 0, 0]) 
	    polygon(
            shape_path_extend(
	            stroke2, 
	            [for(pa = pts_angles) pa[0]]
	        )
        );

![path_extend](images/lib-shape_path_extend-1.JPG)