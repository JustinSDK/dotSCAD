# box_extrude

Creates a box (container) from a 2D object.

## Parameters

- `height` : The box height.
- `shell_thickness` : The thickness between the exterior and interior..

## Examples

    include <box_extrude.scad>;
    
	box_extrude(height = 30, shell_thickness = 2) 
	    circle(r = 30);

![box_extrude](images/lib-box_extrude-1.JPG)

    include <box_extrude.scad>;
    
	box_extrude(height = 30, shell_thickness = 2) 
	    text("XD", size = 40, font = "Cooper Black");

![box_extrude](images/lib-box_extrude-2.JPG)

