# vx_polyline

Given a list of points. `vx_polyline` returns points that can be used to draw a voxel-style polyline.

**Since:** 2.4

## Parameters

- `points` : A list of points. Each point can be `[x, y]` or `[x, y, z]`. x, y, z must be integer.

## Examples

	use <voxel/vx_polyline.scad>
	use <shape_pentagram.scad>

	pentagram = [
		for(pt = shape_pentagram(15)) 
			[round(pt.x), round(pt.y)]
	];

	for(pt = vx_polyline([each pentagram, pentagram[0]])) {
		translate(pt) 
		linear_extrude(1, scale = 0.5) 
			square(1, center = true);
	}

![vx_polyline](images/lib3x-vx_polyline-1.JPG)

	use <voxel/vx_polyline.scad>
	use <sphere_spiral.scad>

	points_angles = sphere_spiral(
		radius = 20, 
		za_step = 5
	);

	points = [
		for(pa = points_angles) 
		let(pt = pa[0])
		[round(pt.x), round(pt.y), round(pt.z)]
	];

	for(a = [0:30:330]) { 
		rotate(a) 
		for(pt = vx_polyline(points)) {
			translate(pt)
				cube(1, center = true);
		}
	}
		
![vx_polyline](images/lib3x-vx_polyline-2.JPG)

