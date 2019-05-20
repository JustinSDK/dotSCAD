# starburst 

A 3D version of [shape_starburst](https://openhome.cc/eGossip/OpenSCAD/lib-shape_starburst.html). 

## Parameters

- `r1` : The outer radius of the starburst. 
- `r2` : The inner radius of the starburst.
- `n`  : The number of vertices. 
- `height` : The height of the starburst.

## Examples

    include <starburst.scad>;

	starburst(10, 5, 5, 5);
	translate([20, 0, 0]) starburst(10, 5, 6, 5);
	translate([40, 0, 0]) starburst(10, 5, 12, 10);
	translate([60, 0, 0]) starburst(10, 5, 4, 3);

![starburst](images/lib-starburst-1.JPG)

