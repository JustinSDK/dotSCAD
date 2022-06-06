# vx_difference

It' slow, in case you want to create a difference of two lists of points directly. 

**Since:** 2.4

## Parameters

- `points1` : A list of points.
- `points2` : A list of points.

## Examples

	use <voxel/vx_difference.scad>
	use <voxel/vx_cylinder.scad>
	use <voxel/vx_sphere.scad>

	voxels = vx_difference(
		vx_cylinder(6, 3, filled = true),
		vx_sphere(3, filled = true)
	);

	for(pt = voxels) {
		translate(pt)
			cube(1, center = true);
	}

![vx_difference](images/lib3x-vx_difference-1.JPG)
