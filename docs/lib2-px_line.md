# px_line

Given two points. `px_line` returns points that can be used to draw a pixel-style line.

**Since:** 2.0

## Parameters

The dir changed since 2.0. 

- `p1` : The start point `[x, y]` or `[x, y, z]`.
- `p2` : The end point `[x, y]` or `[x, y, z]`.

## Examples

	include <pixel/px_line.scad>;

	for(pt = px_line([-10, 0], [20, 50])) {
		translate(pt) 
			square(1, center = true);
	}

![px_line](images/lib2-px_line-1.JPG)

	include <pixel/px_line.scad>;

	for(pt = px_line([-10, 0, -10], [20, 50, 10])) {
		translate(pt) 
			cube(1, center = true);
	}

![px_line](images/lib2-px_line-2.JPG)

