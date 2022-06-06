# circle_path

Sometimes you need all points on the path of a circle. Here's the function. Its `$fa`, `$fs` and `$fn` parameters are consistent with the `circle` module.

## Parameters

- `radius` : The radius of the circle.
- `n` : The number of points you want. It's not greater than the fragments of the circle.
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details.

## Examples

    use <circle_path.scad>

	$fn = 24;
	
	points = circle_path(radius = 50);
	polygon(points);
	
	leng = len(points);
	step_angle = 360 / leng;
	for(i = [0:leng - 1]) {
	    translate(points[i]) 
		rotate([90, 0, 90 + i * step_angle]) 
		linear_extrude(1, center = true) 
			text("A", valign = "center", halign = "center");
	}

![circle_path](images/lib3x-circle_path-1.JPG)

