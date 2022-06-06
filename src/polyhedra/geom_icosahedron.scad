use <_impl/_geom_platonic_polyhedra.scad>

function geom_icosahedron(radius, detail = 0) =
    let(
        t = (1 + sqrt(5)) / 2 ,
        icosahedron_points = [
            [- 1, t, 0],  [1, t, 0],  [- 1, - t, 0], [1, - t, 0],
            [0, - 1, t],  [0, 1, t],  [0, - 1, - t], [0, 1, - t],
            [t, 0, - 1],  [t, 0, 1],  [- t, 0, - 1],  [- t, 0, 1]
        ],
        icosahedron_faces = [
            [5, 11, 0], [1, 5, 0], [7, 1, 0], [10, 7, 0], [11, 10, 0], 
            [9, 5, 1], [4, 11, 5], [2, 10, 11], [6, 7, 10], [8, 1, 7], 
            [4, 9, 3], [2, 4, 3], [6, 2, 3], [8, 6, 3], [9, 8, 3], 
            [5, 9, 4], [11, 4, 2], [10, 2, 6], [7, 6, 8], [1, 8, 9]
        ]
    )
    _subdivide_project(icosahedron_points, icosahedron_faces, radius, detail);
    