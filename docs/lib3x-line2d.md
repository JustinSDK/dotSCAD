# line2d

Creates a line from two points. When the end points are `CAP_ROUND`, you can use `$fa`, `$fs` or `$fn` to controll the `circle` module used internally.

## Parameters

- `p1` : 2 element vector `[x, y]`.
- `p2` : 2 element vector `[x, y]`.
- `width` : The line width. Default to 1.
- `p1Style` : The end-cap style of the point `p1`. The value must be `"CAP_BUTT"`, `"CAP_SQUARE"` or `"CAP_ROUND"`. The default value is `"CAP_SQUARE"`. 
- `p2Style` : The end-cap style of the point `p2`. The value must be `"CAP_BUTT"`, `"CAP_SQUARE"` or `"CAP_ROUND"`. The default value is `"CAP_SQUARE"`. 
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details. The final fragments of a circle will be a multiple of 4 to fit edges.

## Examples

    use <line2d.scad>
    
    $fn = 24;

	line2d(p1 = [0, 0], p2 = [5, 0], width = 1);
	
	translate([0, -2, 0]) 
	    line2d(p1 = [0, 0], p2 = [5, 0], width = 1, 
	           p1Style = "CAP_ROUND", p2Style = "CAP_ROUND");
			   
	translate([0, -4, 0]) 
	    line2d(p1 = [0, 0], p2 = [5, 0], width = 1, 
	           p1Style = "CAP_BUTT", p2Style = "CAP_BUTT");

![line2d](images/lib3x-line2d-1.JPG)
