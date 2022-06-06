use <_impl/_geom_platonic_polyhedra.scad>

function geom_tetrahedron(radius, detail = 0) =
    let(
        t = (1 + sqrt(5)) / 2 ,
        tetrahedron_points = [
			[1, 1, 1], 	[-1, -1, 1], [-1, 1, -1], [1, -1, -1]
		],
        tetrahedron_faces = [
			[0, 1, 2], [2, 3, 0], [0, 3, 1], [1, 3, 2]
		]
    )
    _subdivide_project(tetrahedron_points, tetrahedron_faces, radius, detail);
    