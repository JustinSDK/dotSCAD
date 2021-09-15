use <__comm__/_pt3_hash.scad>;
use <util/dedup.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_get.scad>;
use <experimental/tri_subdivide.scad>;

function _prj2sphere(t, r) = [for(p = t) p / norm(p) * r];

function _pimap_pts(radius, points, leng, hash, m, deduped_pts = [], n = -1, i = 0) =
     i == leng ? [m, deduped_pts] :
     let(v = hashmap_get(m, points[i], hash = hash))
      is_undef(v) ? 
          _pimap_pts(radius, points, leng, hash, hashmap_put(m, points[i], n + 1, hash = hash), concat(deduped_pts, [points[i] / norm(points[i]) * radius]), n + 1, i + 1) :
          _pimap_pts(radius, points, leng, hash, m, deduped_pts, n, i + 1);

function _geom_icosahedron(icosahedron_points, icosahedron_faces, tris, radius, detail) = 
    let(
        points = detail == 0 ? [for(tri = tris) each tri] : [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each t]
        ],
        number_of_buckets = ceil(sqrt(len(points)) * 1.5),
        hash = function(p) _pt3_hash(p),   
        leng = len(points), 
        m_pts = _pimap_pts( 
            radius,
            points, 
            leng, 
            hash,
            hashmap(number_of_buckets = number_of_buckets)
        ),
        faces = [
            for(i = [0:3:leng - 3])
            [
                hashmap_get(m_pts[0], points[i], hash = hash),
                hashmap_get(m_pts[0], points[i + 1], hash = hash),
                hashmap_get(m_pts[0], points[i + 2], hash = hash)
            ]
        ]
    )
    [m_pts[1], faces];

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
    