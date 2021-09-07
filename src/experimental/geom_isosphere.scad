use <experimental/tri_subdivide.scad>;

function _prj2sphere(t, r) = [for(p = t) p / norm(p) * r];

function geom_isosphere(radius, detail = 0) =
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
        ],
        tris = [
            for(face = icosahedron_faces)
            [for(i = face) icosahedron_points[i]]
        ],
        points = detail == 0 ? [for(tri = tris) each _prj2sphere(tri, radius)] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each _prj2sphere(t, radius)]
        ],
        faces = [for(i = [0:3:len(points) - 3]) [i, i + 1, i + 2]]
    )
    [points, faces];
    