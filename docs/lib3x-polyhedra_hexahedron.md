# hexahedron

Creates a hexahedron.

**Since:** 3.2

## Parameters

- `radius` : Radius of the hexahedron.
- `detail` : Default to 0. Setting this to a value greater than 0 adds vertices making it no longer a hexahedron.

## Examples

	use <polyhedra/hexahedron.scad>

	for(i = [0:5]) {
		translate([i * 2, 0])
			hexahedron(radius = 1, detail = i);
	}

![hexahedron](images/lib3x-polyhedra_hexahedron-1.JPG)

