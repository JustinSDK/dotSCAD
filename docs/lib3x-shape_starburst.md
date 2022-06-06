# shape_starburst

Returns shape points of a star. They can be used with xxx_extrude modules of dotSCAD. The shape points can be also used with the built-in polygon module. 

## Parameters

- `r1` : The outer radius of the starburst. 
- `r2` : The inner radius of the starburst.
- `n`  : The burst number. 


## Examples

	use <shape_starburst.scad>
	
	polygon(shape_starburst(30, 12, 6));

![shape_starburst](images/lib3x-shape_starburst-1.JPG)

	use <shape_starburst.scad>
	use <golden_spiral_extrude.scad>
	
	shape_pts = shape_starburst(5, 2, 8);
	
	golden_spiral_extrude(
	    shape_pts, 
	    from = 5, 
	    to = 10, 
	    point_distance = 1,
	    scale = 10
	);

![shape_pentagram](images/lib3x-shape_starburst-2.JPG)

