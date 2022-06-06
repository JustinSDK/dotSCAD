# tetrahedron

Creates a tetrahedron.

**Since:** 3.2

## Parameters

- `radius` : Radius of the tetrahedron.
- `detail` : Default to 0. Setting this to a value greater than 0 adds vertices making it no longer a tetrahedron.

## Examples

	use <polyhedra/tetrahedron.scad>

	for(i = [0:5]) {
		translate([i * 2, 0])
			tetrahedron(radius = 1, detail = i);
	}

![tetrahedron](images/lib3x-polyhedra_tetrahedron-1.JPG)

