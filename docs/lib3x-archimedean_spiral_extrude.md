# archimedean_spiral_extrude

Extrudes a 2D shape along the path of an archimedean spiral. 

When using this module, you should use points to represent the 2D shape. If your 2D shape is not solid, indexes of triangles are required. See [sweep](https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html) for details.

## Parameters

- `shape_pts` : A list of points represent a shape. See the example below.
- `arm_distance`, `init_angle`, `point_distance`, `num_of_points` and `rt_dir` : See [archimedean_spiral](https://openhome.cc/eGossip/OpenSCAD/lib3x-archimedean_spiral.html) for details.
- `twist` : The number of degrees of through which the shape is extruded.
- `scale` : Scales the 2D shape by this value over the length of the extrusion. Scale can be a scalar or a vector.
- `triangles` : `"SOLID"` (default), `"HOLLOW"` or user-defined indexes. See [sweep](https://openhome.cc/eGossip/OpenSCAD/lib3x-sweep.html) for details.

## Examples
    
	use <archimedean_spiral_extrude.scad>

	shape_pts = [
		[5, 0],
		[5, 4],
		[4, 4], 
		[4, 2], 
		[-4, 2],
		[-4, 4],
		[-5, 4],
		[-5, 0]
	];

	archimedean_spiral_extrude(
		shape_pts,
		arm_distance = 15,  
		init_angle = 180, 
		point_distance = 5,
		num_of_points = 100,
		scale = [1, 5]
	);

![archimedean_spiral_extrude](images/lib3x-archimedean_spiral_extrude-1.JPG)

