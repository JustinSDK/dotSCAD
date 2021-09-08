use <__comm__/_pt3_hash.scad>;
use <util/dedup.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_get.scad>;
use <experimental/tri_subdivide.scad>;

function _prj2sphere(t, r) = [for(p = t) p / norm(p) * r];

function _geom_icosahedron(icosahedron_points, icosahedron_faces, tris, radius, detail) = 
    let(
        points = detail == 0 ? [for(tri = tris) each tri] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each t]
        ],
        number_of_buckets = ceil(sqrt(len(points))),
        hash = _pt3_hash(number_of_buckets),        
        deduped_pts = dedup(points, hash = hash, number_of_buckets = number_of_buckets),
        pts = [for(p = deduped_pts) p / norm(p) * radius],
        m = hashmap([
            for(i = [0:len(deduped_pts) - 1])
            [deduped_pts[i], i]
        ], hash = hash, number_of_buckets = number_of_buckets),
        faces = [
            for(i = [0:3:len(points) - 3])
            [
                hashmap_get(m, points[i], hash = hash),
                hashmap_get(m, points[i + 1], hash = hash),
                hashmap_get(m, points[i + 2], hash = hash)
            ]
        ]
    )
    [pts, faces];

function _geom_icosahedron_quick(icosahedron_points, icosahedron_faces, tris, radius, detail) = 
    let(
        points = detail == 0 ? [for(tri = tris) each _prj2sphere(tri, radius)] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each _prj2sphere(t, radius)]
        ],
        faces = [for(i = [0:3:len(points) - 3]) [i, i + 1, i + 2]]
    )
    [points, faces];

function geom_icosahedron(radius, detail = 0, quick_mode = true) =
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
        ]
    )
    quick_mode ? _geom_icosahedron_quick(icosahedron_points, icosahedron_faces, tris, radius, detail) :
                 _geom_icosahedron(icosahedron_points, icosahedron_faces, tris, radius, detail);
    