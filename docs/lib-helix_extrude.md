# helix_extrude

Extrudes a 2D shape along a helix path. 

When using this module, you should use points to represent the 2D shape. You need to provide indexes of triangles, too. This module provides two prepared triangles indexes. One is `"RADIAL"`. See [polysections](https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html) for details.

Its `$fa`, `$fs` and `$fn` parameters are consistent with the `cylinder` module. 

Dependencies: `circle_path`, `helix`, `rotate_p.scad`, `cross_sections`, `polysections`.

## Parameters

- `shape_pts` : A list of points represent a shape. See the example below.
- `radius` : The radius of the cylinder.
- `levels` : The level count is performed every 360 degrees. 
- `level_dist` : The distance between two vertial points.
- `vt_dir` : `"SPI_DOWN"` for spiraling down. `"SPI_UP"` for spiraling up. The default value is `"SPI_DOWN"`.
- `rt_dir` : `"CT_CLK"` for counterclockwise. `"CLK"` for clockwise. The default value is `"CT_CLK"`.
- `twist` : The number of degrees of through which the shape is extruded.
- `scale` : Scales the 2D shape by this value over the length of the extrusion. Scale can be a scalar or a vector.
- `triangles` : `"RADIAL"` (default), `"HOLLOW"` or user-defined indexes. See [polysections](https://openhome.cc/eGossip/OpenSCAD/lib-polysections.html) for details.
- `$fa`, `$fs`, `$fn` : Check [the cylinder module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#cylinder) for more details.

## Examples
    
	include <circle_path.scad>;
	include <helix.scad>;
	include <rotate_p.scad>;
	include <cross_sections.scad>;
	include <polysections.scad>;
	include <helix_extrude.scad>;

	shape_pts = [
		[-5, -2], [-5, 2],
		[-4, 2], [-4, 0],
		[4, 0], [4, 2],
		[5, 2], [5, -2]
	];

	helix_extrude(shape_pts, 
		radius = 40, 
		levels = 5, 
		level_dist = 10,
		vt_dir = "SPI_UP",
		triangles = [
			[0, 1, 2],
			[0, 2, 3],
			[0, 3, 4],
			[0, 4, 7],
			[4, 5, 6],
			[4, 6, 7]
		]
	);

![helix_extrude](images/lib-helix_extrude-1.JPG)

