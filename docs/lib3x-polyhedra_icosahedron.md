# icosahedron

Creates a icosahedron.

**Since:** 3.2

## Parameters

- `radius` : Radius of the icosahedron.
- `detail` : Default to 0. Setting this to a value greater than 0 adds vertices making it no longer a icosahedron.

## Examples

	use <polyhedra/icosahedron.scad>

	for(i = [0:5]) {
		translate([i * 2, 0])
			icosahedron(radius = 1, detail = i);
	}

![icosahedron](images/lib3x-polyhedra_icosahedron-1.JPG)

