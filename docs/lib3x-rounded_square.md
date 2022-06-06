# rounded_square

Creates a rounded square or rectangle in the first quadrant. 

## Parameters

- `size` : Accepts single value, square with both sides this length. It also accepts 2 value array `[x, y]`, rectangle with dimensions `x` and `y`.
- `corner_r` : The corner is one-quarter of a circle (quadrant). The `corner_r` parameter determines the circle radius.
- `center` : `false` (default), 1st (positive) quadrant, one corner at (0,0). `true`, square is centered at (0,0).
- `$fa`, `$fs`, `$fn` : Used to control the four quadrants. Check [the circle module](https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/Using_the_2D_Subsystem#circle) for more details.

## Examples

    use <rounded_square.scad>

    rounded_square(size = 50, corner_r = 5);

![rounded_square](images/lib3x-rounded_square-1.JPG)

	use <rounded_square.scad>
	
	rounded_square(
	    size = [50, 25],
	    corner_r = 5, 
	    center = true
	);

![rounded_square](images/lib3x-rounded_square-2.JPG)

	use <rounded_square.scad>
	
	$fn = 4;
	rounded_square(
	    size = [50, 25],
	    corner_r = 5, 
	    center = true
	);

![rounded_square](images/lib3x-rounded_square-3.JPG)




