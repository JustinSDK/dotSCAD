# vx_bezier

Given 4 control points, returns voxel-by-voxel points of Bézier Curve .

**Since:** 2.5

## Parameters

- `p1` : The 1st control point.
- `p2` : The 2nd control point.
- `p3` : The 3rd control point.
- `p4` : The 4th control point.

## Examples

	use <voxel/vx_bezier.scad>

	t_step = 0.05;
	width = 2;
	
	p1 = [0, 0, 0];
	p2 = [30, 15, 25];
	p3 = [-35, 20, -20];
	p4 = [10, 40, 9];
	
	points = vx_bezier( 
	   p1, p2, p3, p4
	);
	
	for(p = points) {
		translate(p)
		    cube(1);
	}     

![vx_bezier](images/lib3x-vx_bezier-1.JPG)
