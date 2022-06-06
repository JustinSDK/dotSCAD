# bezier_curve

Given a set of control points, the `bezier_curve` function returns points of the Bézier path. 

## Parameters

- `t_step` : 0 ~ 1. Control the distance between two points of the Bézier path.
- `points` : A list of `[x, y]` or `[x, y, z]` control points.

## Examples

If you have four control points:

    use <polyline_join.scad>
	use <bezier_curve.scad>

	t_step = 0.05;
	radius = 2;
	
	p0 = [0, 0, 0];
	p1 = [40, 60, 35];
	p2 = [-50, 90, 0];
	p3 = [0, 200, -35];
	
	points = bezier_curve(t_step, 
	    [p0, p1, p2, p3]
	);
	
	polyline_join(points)
	    sphere(radius);      

![bezier_curve](images/lib3x-bezier_curve-1.JPG)
