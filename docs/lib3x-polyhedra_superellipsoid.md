# superellipsoid

Creates a [superellipsoid](https://en.wikipedia.org/wiki/Superellipsoid).

**Since:** 3.2

## Parameters

- `e` :  The east-west parameter.
- `n` : The north-south parameter.

## Examples

	use <polyhedra/superellipsoid.scad>

	$fn = 24;

	step = 0.5;

	for(e = [0:step:4], n = [0:step:4]) {
		translate([e / step, n / step] * 3)
			superellipsoid(e, n);
	}

![superellipsoid](images/lib3x-polyhedra_superellipsoid-1.JPG)

