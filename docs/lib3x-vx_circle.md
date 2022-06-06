# vx_circle

Returns points that can be used to draw a voxel-style circle.

**Since:** 2.4

## Parameters

- `radius` : The circle radius. The value must be an integer.
- `filled` : Default to `false`. Set it `true` if you want a filled circle.

## Examples

	use <voxel/vx_circle.scad>

	for(pt = vx_circle(10)) {
		translate(pt)
			square(1, center = true);
	}

![vx_circle](images/lib3x-vx_circle-1.JPG)

	use <voxel/vx_circle.scad>

	for(pt = vx_circle(10, filled = true)) {
		translate(pt)
		linear_extrude(1, scale = 0.5) 
			square(1, center = true);
	}
		
![vx_circle](images/lib3x-vx_circle-2.JPG)

