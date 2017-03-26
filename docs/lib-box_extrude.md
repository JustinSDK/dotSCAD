# box_extrude

Create a box (container) from a 2D object.

## Parameters

- `height` : The box height.
- `shell_thickness` : The thickness between the exterior and interior..

## Examples

	box_extrude(height = 30, shell_thickness = 2) 
	    circle(r = 30);

![box_extrude](images/lib-box_extrude-1.JPG)

	box_extrude(height = 30, shell_thickness = 2) 
	    text("XD", size = 40, font = "Cooper Black");

![box_extrude](images/lib-box_extrude-2.JPG)

