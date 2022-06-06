# vx_sphere

Returns points that can be used to draw a voxel-style sphere.

**Since:** 2.4

## Parameters

- `radius` : The radius of the sphere. The value must be an integer.
- `filled` : Default to `false`. Set it `true` if you want a filled sphere.
- `thickness`: Default to 1. The thickness when `filled` is `false`. The value must be an integer.

## Examples

	use <voxel/vx_sphere.scad>

	for(pt = vx_sphere(10)) {
		translate(pt)
			cube(1, center = true);
	}

![vx_sphere](images/lib3x-vx_sphere-1.JPG)
