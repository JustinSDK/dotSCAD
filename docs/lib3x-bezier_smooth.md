# bezier_smooth

Given a path, the `bezier_smooth` function uses bazier curves to smooth all corners. You can use it to create smooth lines or rounded shapes.

## Parameters

- `path_pts` : A list of points represent the path.
- `round_d` : Used to create the other two control points at the corner.
- `t_step` : The distance between two points of the Bézier path at the corner. It defaults to 0.1.
- `closed` : It defaults to `false`. If you have a closed path, set it to `true`.
- `angle_threshold` : Default to 0. If the angle between two line segments is bigger than `angle_threshold`, smooth those two segments. **Since:** 3.0

## Examples

	use <polyline_join.scad>
	use <bezier_smooth.scad>

	width = 2;
	round_d = 15;

	path_pts = [
		[0, 0, 0],
		[40, 60, 10],
		[-50, 90, 30],
		[-10, -10, 50]
	];

	polyline_join(path_pts)
	    sphere(width / 2);

	smoothed_path_pts = bezier_smooth(path_pts, round_d);

	color("red") 
	translate([30, 0, 0]) 
	polyline_join(smoothed_path_pts) 
	    sphere(width / 2);

![bezier_smooth](images/lib3x-bezier_smooth-1.JPG)

	use <bezier_smooth.scad>

	round_d = 10;

	path_pts = [
		[0, 0],
		[40, 0],
		[0, 60]
	];

	polygon(path_pts);

	smoothed_path_pts = bezier_smooth(path_pts, round_d, closed = true);

	translate([50, 0, 0]) 
	    polygon(smoothed_path_pts);

![bezier_smooth](images/lib3x-bezier_smooth-2.JPG)