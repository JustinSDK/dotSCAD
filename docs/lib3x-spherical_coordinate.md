# spherical_coordinate

Converts from Cartesian to Spherical coordinates (used in mathematics). It returns `[radius, theta, phi]`.

**Since:** 3.0

## Parameters

- `point` : The Cartesian coordinates of a point.

## Examples

    use <util/spherical_coordinate.scad>
    
	coord = spherical_coordinate([100, 100, 100]);
	r = round(coord[0]);
	theta = round(coord[1]);
	phi = round(coord[2]);
    assert([r, theta, phi] == [173, 45, 55]);  