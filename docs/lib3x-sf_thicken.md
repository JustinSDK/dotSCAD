# sf_thicken

It thickens a surface, described by a m * n list of `[x, y, z]`s.

## Parameters

- `points` : A m * n list of `[x, y, z]`s. See examples below.
- `thickness` : The depth of the thickening.
- `direction` : The direction of thickening. It accepts `"BOTH"` (default), `"FORWARD"` or `"BACKWARD"`. Thickening is applied in both directions from the surface, the direction of the surface normals or the opposite direction to the surface normals. It also accept a direction vector `[x, y, z]`. Thickening is only applied in the direction you give.
- `swap_surface` : The direction of thickening. 

## Examples

	use <sf_thicken.scad>;
	
	points = [
	    [[0, 0, 1], [1, 0, 2], [2, 0, 2], [3, 0, 3]],
	    [[0, 1, 1], [1, 1, 4], [2, 1, 0], [3, 1, 3]],
	    [[0, 2, 1], [1, 2, 3], [2, 2, 1], [3, 2, 3]],
	    [[0, 3, 1], [1, 3, 3], [2, 3, 1], [3, 3, 3]]
	];
	
	thickness = 0.5;
	
	sf_thicken(points, thickness);

![sf_thicken](images/lib3x-sf_thicken-1.JPG)

	use <sf_thicken.scad>;
	
	function f(x, y) = 
	   30 * (
	       cos(sqrt(pow(x, 2) + pow(y, 2))) + 
	       cos(3 * sqrt(pow(x, 2) + pow(y, 2)))
	   );
	
	thickness = 2;
	min_value =  -200;
	max_value = 200;
	resolution = 10;
	
	points = [
	    for(y = [min_value:resolution:max_value])
	        [
	            for(x = [min_value:resolution:max_value]) 
	                [x, y, f(x, y)]
	        ]
	];
	
	sf_thicken(points, thickness);

![sf_thicken](images/lib3x-sf_thicken-2.JPG)

	use <sf_thicken.scad>;

	function f(x, y) = 
	   30 * (
	       cos(sqrt(pow(x, 2) + pow(y, 2))) + 
	       cos(3 * sqrt(pow(x, 2) + pow(y, 2)))
	   );
	
	thickness = 2;
	min_value =  -200;
	max_value = 200;
	resolution = 10;
	style = "LINES"; 
	
	points = [
	    for(y = [min_value:resolution:max_value])
	        [
	            for(x = [min_value:resolution:max_value]) 
	                [x, y, f(x, y)]
	        ]
	];
	
	sf_thicken(points, thickness, style);

![sf_thicken](images/lib3x-sf_thicken-3.JPG)