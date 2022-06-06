use <_impl/_geom_platonic_polyhedra.scad>

function geom_octahedron(radius, detail = 0) =
    let(
        octahedron_points = [
			[1, 0, 0], 	[-1, 0, 0],	[0, 1, 0],
			[0, -1, 0], [0, 0, 1],	[0, 0, -1]
		],
        octahedron_faces = [
			[4, 2, 0],	[3, 4, 0],	[5, 3, 0],
			[2, 5, 0],	[5, 2, 1],	[3, 5, 1],
			[4, 3, 1],	[2, 4, 1]
		]
    )
    _subdivide_project(octahedron_points, octahedron_faces, radius, detail);
    