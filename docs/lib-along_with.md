# along_with

Puts children along the given path. If there's only one child, it will put the child for each point. 

## Parameters

- `points` : The points along the path. 

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

