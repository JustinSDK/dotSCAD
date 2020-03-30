# px_cylinder

Returns points that can be used to draw a pixel-style cylinder.

**Since:** 2.0

## Parameters

- `radius` : The radius of the cylinder. It also accepts a vector `[r1, r2]`. `r1` is the bottom radius and `r2` is the top radius of a cone. Values must be an integer.
- `h` : The height of the cylinder or cone. 
- `filled` : Default to `false`. Set it `true` if you want a filled cylinder.
- `thickness`: Default to 1. The thickness when `filled` is `false`. The value must be an integer.

## Examples

	use <pixel/px_cylinder.scad>;

	for(pt = px_cylinder([10, 15], 10)) {
		translate(pt)
			cube(1, center = true);
	}

![px_cylinder](images/lib2x-px_cylinder-1.JPG)

	use <pixel/px_cylinder.scad>;

	for(pt = px_cylinder([20, 15], h = 10, thickness = 3)) {
		translate(pt)
			cube(1, center = true);
	}
	
![px_cylinder](images/lib2x-px_cylinder-2.JPG)

