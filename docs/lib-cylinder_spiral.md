# cylinder_spiral

Get all points on the path of a spiral around a cylinder. Its `$fa`, `$fs` and `$fn` parameters are consistent with the `cylinder` module. It depends on the `circle_path` module so you have to include circle_path.scad.

## Parameters

- `radius` : The radius of the cylinder.
- `levels` : The level count is performed every 360 degrees. 
- `level_dist` : The distance between two vertial points.
- `vt_dir` : `"SPI_DOWN"` for spiraling down. `"SPI_UP"` for spiraling up. The default value is `"SPI_DOWN"`.
- `rt_dir` : `"CT_CLK"` for counterclockwise. `"CLK"` for clockwise. The default value is `"CT_CLK"`.
- `$fa`, `$fs`, `$fn` : Check [the cylinder module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#cylinder) for more details.


## Examples
    
	include <circle_path.scad>;
	include <cylinder_spiral.scad>;
	include <hull_polyline3d.scad>;
	
	$fn = 12;
	
	points = cylinder_spiral(
	    radius = 40, 
	    levels = 10, 
	    level_dist = 10, 
	    vt_dir = "SPI_UP", 
	    rt_dir = "CLK"
	);
	
	for(p = points) {
	    translate(p) sphere(5);
	}
	
	hull_polyline3d(points, 2);


![cylinder_spiral](images/lib-cylinder_spiral-1.JPG)

