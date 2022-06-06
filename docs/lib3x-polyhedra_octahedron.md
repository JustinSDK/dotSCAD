# octahedron

Creates a octahedron.

**Since:** 3.2

## Parameters

- `radius` : Radius of the octahedron.
- `detail` : Default to 0. Setting this to a value greater than 0 adds vertices making it no longer a octahedron.

## Examples

	use <polyhedra/octahedron.scad>

	for(i = [0:5]) {
		translate([i * 2, 0])
			octahedron(radius = 1, detail = i);
	}

![octahedron](images/lib3x-polyhedra_octahedron-1.JPG)

