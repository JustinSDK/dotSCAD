# along_with

Puts children along the given path. If there's only one child, it will put the child for each point. 

## Parameters

- `points` : The points along the path. 
- `angles` : If it's given, rotate before translate each child.

## Examples

	include <along_with.scad>;
	include <circle_path.scad>;
	
	$fn = 24;
	
	points = circle_path(radius = 50);
	
	along_with(points) 
	    sphere(5, center = true);

![along_with](images/lib-along_with-1.JPG)

	include <along_with.scad>;
	include <circle_path.scad>;
	
	$fn = 24;
	
	points = circle_path(radius = 50);
	
	along_with(points) {
	    linear_extrude(10) text("A", valign = "center", halign = "center");
	    linear_extrude(5) circle(2);
	    sphere(1);
	    cube(5);
	    linear_extrude(10) text("A", valign = "center", halign = "center");
	    linear_extrude(5) circle(2);
	    sphere(1);
	    cube(5);        
	}

![along_with](images/lib-along_with-2.JPG)

	include <along_with.scad>;
	include <circle_path.scad>;
	include <rotate_p.scad>;
	include <golden_spiral.scad>;

	pts_angles = golden_spiral(
		from = 5, 
		to = 11, 
		point_distance = 4
	);

	points = [for(p_a = pts_angles) p_a[0]];
	angles = [for(p_a = pts_angles) p_a[1]];

	along_with(points, angles)
		rotate([90, 0, 0]) 
			linear_extrude(1, center = true) 
				text("A", valign = "center", halign = "center");

![along_with](images/lib-along_with-3.JPG)