# px_line

Given two points. `px_line` returns points that can be used to draw a pixel-style line.

**Since:** 2.0

## Parameters

- `p1` : The start point `[x, y]` or `[x, y, z]`. x, y, z must be integer.
- `p2` : The end point `[x, y]` or `[x, y, z]`. x, y, z must be integer.

## Examples

	use <pixel/px_line.scad>;

	for(pt = px_line([-10, 0], [20, 50])) {
		translate(pt) 
			square(1, center = true);
	}

![px_line](images/lib2x-px_line-1.JPG)

	use <pixel/px_line.scad>;

	for(pt = px_line([-10, 0, -10], [20, 50, 10])) {
		translate(pt) 
			cube(1, center = true);
	}

![px_line](images/lib2x-px_line-2.JPG)

