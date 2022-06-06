# hollow_out

Hollows out a 2D object. 

## Parameters

- `shell_thickness` : The thickness between the exterior and interior.

## Examples

    use <hollow_out.scad>

	hollow_out(shell_thickness = 1) 
        circle(r = 3, $fn = 48);
    
    hollow_out(shell_thickness = 1) 
        square([10, 5]);

![hollow_out](images/lib3x-hollow_out-1.JPG)
