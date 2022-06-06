# polar_coordinate

Converts from Cartesian to Polar coordinates. It returns `[radius, theta]`.

**Since:** 3.0

## Parameters

- `point` : The Cartesian coordinates of a point.

## Examples

    use <util/polar_coordinate.scad>
    
	coord = polar_coordinate([100, 100]);
	r = round(coord[0]);
	theta = round(coord[1]);
    assert([r, theta] == [141, 45]);  