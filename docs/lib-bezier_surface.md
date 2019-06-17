# bezier_surface

Given a set of control points, the `bezier_surface` function returns points of the Bézier surface. Combined with the `function_grapher` module defined in my library, you can create a Bézier surface.

## Parameters

- `t_step` : The distance between two points of the Bézier path.
- `points` : A set of control points. See examples below.

## Examples

If you have 16 control points and combine with the `function_grapher` module:

	include <bezier_curve.scad>;
	include <bezier_surface.scad>; 
	include <function_grapher.scad>;

	t_step = 0.05;
	thickness = 0.5;

	ctrl_pts = [
		[[0, 0, 20],  [60, 0, -35],   [90, 0, 60],    [200, 0, 5]],
		[[0, 50, 30], [100, 60, -25], [120, 50, 120], [200, 50, 5]],
		[[0, 100, 0], [60, 120, 35],  [90, 100, 60],  [200, 100, 45]],
		[[0, 150, 0], [60, 150, -35], [90, 180, 60],  [200, 150, 45]]
	];

	g = bezier_surface(t_step, ctrl_pts);
	function_grapher(g, thickness);    

![bezier_surface](images/lib-bezier_surface-1.JPG)

The following figure shows controll points and bazier curves around the surface.

![bezier_surface](images/lib-bezier_surface-2.JPG)