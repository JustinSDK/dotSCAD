# shape_pentagram

Returns shape points of a pentagram. They can be used with xxx_extrude modules of dotSCAD. The shape points can be also used with the built-in polygon module. 

## Parameters

- `r` : The length between the center and a tip.

## Examples

	use <shape_pentagram.scad>

	polygon(shape_pentagram(5));

![shape_pentagram](images/lib3x-shape_pentagram-1.JPG)

	use <shape_pentagram.scad>
	use <golden_spiral_extrude.scad>

	shape_pts = shape_pentagram(2);

	golden_spiral_extrude(
		shape_pts, 
		from = 5, 
		to = 10, 
		point_distance = 1,
		scale = 10
	);

![shape_pentagram](images/lib3x-shape_pentagram-2.JPG)

