# px_sphere

Returns points that can be used to draw a pixel-style sphere.

**Since:** 2.0

## Parameters

- `radius` : The radius of the sphere. The value must be an integer.
- `filled` : Default to `false`. Set it `true` if you want a filled sphere.
- `thickness`: Default to 1. The thickness when `filled` is `false`. The value must be an integer.

## Examples

	use <pixel/px_sphere.scad>;

	for(pt = px_sphere(10)) {
		translate(pt)
			cube(1, center = true);
	}

![px_sphere](images/lib2x-px_sphere-1.JPG)
