# polygon_hull

Create a convex polygon by hulling a list of points. It avoids using `hull` and small 2D primitives to create the polygon.

**Since:** 2.5

## Parameters

- `points` : A list of 2D points.

## Examples

	use <polygon_hull.scad>

	polygon_hull([
		[1, 1],
		[1, 0],
		[0, 1],
		[-2, 1],
		[-1, -1]
	]);

![polygon_hull](images/lib3x-polygon_hull-1.JPG)