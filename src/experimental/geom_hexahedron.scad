use <experimental/_impl/_geom_platonic_polyhedra.scad>;

function geom_hexahedron(radius, detail = 0, quick_mode = true) =
    let(
        t = 1 / sqrt(3),
        hexahedron_points = [
			[t, t, t], [-t, t, t], [-t, -t, t], [t, -t, t],
            [t, t, -t], [-t, t, -t], [-t, -t, -t], [t, -t, -t]
		],
        hexahedron_faces = [
            [0, 7, 3], [0, 4, 7], 
            [1, 4, 0], [1, 5, 4],
            [2, 6, 5], [2, 5, 1],
            [3, 7, 6], [3, 6, 2],
            [0, 3, 2], [0, 2, 1],
            [5, 6, 7], [5, 7, 4]
		]
    )
	_geom_platonic_polyhedra(hexahedron_points, hexahedron_faces, radius, detail, quick_mode);