# sf_thicken

It thickens a surface, described by a m * n list of `[x, y, z]`s.

## Parameters

- `points` : A m * n list of `[x, y, z]`s. See examples below.
- `thickness` : The depth of the thickening.
- `direction` : The direction of thickening. It accepts `"BOTH"` (default), `"FORWARD"` or `"BACKWARD"`. Thickening is applied in both directions from the surface, the direction of the surface normals or the opposite direction to the surface normals. It also accept a direction vector `[x, y, z]`. Thickening is only applied in the direction you give.
- `convexity` : Integer. This parameter is needed only for correct display of the object in OpenCSG preview mode. It has no effect on the polyhedron rendering. For display problems, setting it to 10 should work fine for most cases. **Since:** 3.3

## Examples

	use <surface/sf_thicken.scad>

	points = [
		[[0, 0, 1], [1, 0, 2.5], [2, 0, 2], [3, 0, 2.5]],
		[[0, 1, 1], [1, 1, 2], [2, 1, 1], [3, 1, 2]],
		[[0, 2, 1], [1, 2, 2.3], [2, 2, 2], [3, 2, 2.2]],
		[[0, 3, 1], [1, 3, 2], [2, 3, 1], [3, 3, 2]]
	];

	thickness = 0.25;

	sf_thicken(points, thickness);

![sf_thicken](images/lib3x-sf_thicken-1.JPG)

	use <surface/sf_thicken.scad>

	function f(x, y) = 
        let(leng = norm([x, y]))
		30 * (cos(leng) + cos(3 * leng));

	thickness = 3;
	min_value =  -200;
	max_value = 200;
	resolution = 10;

	surface1 = [
		for(y = [min_value:resolution:max_value])
		[
			for(x = [min_value:resolution:max_value]) 
				[x, y, f(x, y) + 100]
		]
	];
	sf_thicken(surface1, thickness);

![sf_thicken](images/lib3x-sf_thicken-2.JPG)

	use <surface/sf_thicken.scad>

	function f(x, y) = x + y;

	thickness = 20;
	min_value = -50;
	max_value = 50;
	resolution = 5;

	surface1 = [
		for(y = [min_value:resolution:max_value])
		[
			for(x = [min_value:resolution:max_value]) 
				[x, y, f(x, y) + 100]
		]
	];
	sf_thicken(surface1, thickness, direction = [1, 1, -1]);

![sf_thicken](images/lib3x-sf_thicken-3.JPG)