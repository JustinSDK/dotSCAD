# crystal_ball

Uses spherical coordinate system to create a crystal ball.  

![Spherical coordinates (r, θ, φ) often used in mathematics](https://upload.wikimedia.org/wikipedia/commons/d/dc/3D_Spherical_2.svg)

## Parameters

- `radius` : The radial distance r. 
- `theta` : The azimuthal angle. It defaults to 360. It also accepts a 2 element vector. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `phi` : The polar angle. It defaults to 180. It also accepts a 2 element vector. The first element of the vector is the beginning angle in degrees, and the second element is the ending angle.
- `thickness` : The thickness of the ball. **Since:** 2.1
- `$fa`, `$fs`, `$fn` : Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) or [the sphere module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Primitive_Solids#sphere) for more details. The final fragments will be a multiple of 4 to fit edges.

## Examples

	use <crystal_ball.scad>

	crystal_ball(radius = 6);

	translate([12, 0, 0]) 
		crystal_ball(
			radius = 6, 
			theta = 270,
			thickness = 1,
			$fn = 12
		);

	translate([24, 0, 0]) 
		crystal_ball(
			radius = 6, 
			theta = 270,
			phi = 90,
			$fn = 12
		);    

	translate([36, 0, 0]) 
		crystal_ball(
			radius = 6, 
			theta = [-30, 270],
			phi = [30, 60],
			thickness = 2
		);           

![crystal_ball](images/lib3x-crystal_ball-1.JPG)
