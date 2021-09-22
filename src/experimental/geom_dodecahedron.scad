use <experimental/tri_subdivide.scad>;
use <experimental/_impl/_geom_prj2sphere.scad>;
use <experimental/_impl/_geom_pts_faces.scad>;

function _geom_dodecahedron(dodecahedron_points, tris, radius, detail) = 
    let(
        points = detail == 0 ? [for(tri = tris) each tri] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each t]
        ]
    )
    _geom_pts_faces(points, radius);

function _geom_dodecahedron_quick(dodecahedron_points, tris, radius, detail) = 
    let(
        points = detail == 0 ? [for(tri = tris) each _geom_prj2sphere(tri, radius)] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each _geom_prj2sphere(t, radius)]
        ],
        faces = [for(i = [0:3:len(points) - 3]) [i, i + 1, i + 2]]
    )
    [points, faces];

function geom_dodecahedron(radius, detail = 0, quick_mode = true) =
    let(
        t = (1 + sqrt(5)) / 2,
		r = 1 / t,
        dodecahedron_points = [
			// (±1, ±1, ±1)
			[-1, -1, -1], [-1, -1, 1],
			[-1, 1, -1], [-1, 1, 1],
			[1, -1, -1], [1, -1, 1],
			[1, 1, -1], [1, 1, 1],

			// (0, ±1/φ, ±φ)
			[0, -r, -t], [0, -r, t],
			[0, r, -t], [0, r, t],

			// (±1/φ, ±φ, 0)
			[-r, -t, 0], [-r, t, 0],
			[r, -t, 0], [r, t, 0],

			// (±φ, 0, ±1/φ)
			[-t, 0, -r], [t, 0, -r],
			[-t, 0, r], [t, 0, r]
		],
        dodecahedron_faces = [
			[7, 11, 3], [15, 7, 3], [13, 15, 3], 
			[17, 19, 7], [6, 17, 7], [15, 6, 7], 
			[8, 4, 17], [10, 8, 17], [6, 10, 17], 
			[16, 0, 8], [2, 16, 8], [10, 2, 8], 
			[1, 12, 0], [18, 1, 0], [16, 18, 0], 
			[2, 10, 6], [13, 2, 6], [15, 13, 6], 
			[18, 16, 2], [3, 18, 2], [13, 3, 2], 
			[9, 1, 18], [11, 9, 18], [3, 11, 18], 
			[12, 14, 4], [0, 12, 4], [8, 0, 4],
			[5, 9, 11], [19, 5, 11], [7, 19, 11], 
			[14, 5, 19], [4, 14, 19], [17, 4, 19], 
			[14, 12, 1], [5, 14, 1], [9, 5, 1]
		],
        tris = [
            for(face = dodecahedron_faces)
            [for(i = face) dodecahedron_points[i]]
        ]
    )
    quick_mode ? _geom_dodecahedron_quick(dodecahedron_points, tris, radius, detail) :
                 _geom_dodecahedron(dodecahedron_points, tris, radius, detail);