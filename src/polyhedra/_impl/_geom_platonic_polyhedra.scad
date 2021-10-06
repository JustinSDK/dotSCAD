use <../../__comm__/_pt3_hash.scad>;
use <../../util/map/hashmap.scad>;
use <../../util/map/hashmap_put.scad>;
use <../../util/map/hashmap_get.scad>;

function _tri_subdivide(points) =
     let(
	     p0 = points[0],
		 p1 = points[1],
		 p2 = points[2],
		 m0 = (p0 + p1) / 2,
		 m1 = (p1 + p2) / 2,
		 m2 = (p2 + p0) / 2
	 )
	 [
	     [p0, m0, m2],
		 [m0, p1, m1],
		 [m1, p2, m2],
		 [m0, m1, m2]
	 ]; 

function tri_subdivide(points, n = 1) =
    n == 1 ? _tri_subdivide(points) :
	[for(tri = tri_subdivide(points, n - 1)) each _tri_subdivide(tri)];

function _geom_prj2sphere(t, r) = [for(p = t) p / norm(p) * r];

function _pimap_pts(radius, points, leng, hash, m, deduped_pts = [], n = -1, i = 0) =
     i == leng ? [m, deduped_pts] :
     let(v = hashmap_get(m, points[i], hash = hash))
      is_undef(v) ? 
          _pimap_pts(radius, points, leng, hash, hashmap_put(m, points[i], n + 1, hash = hash), concat(deduped_pts, [points[i] / norm(points[i]) * radius]), n + 1, i + 1) :
          _pimap_pts(radius, points, leng, hash, m, deduped_pts, n, i + 1);

function _geom_pts_faces(points, radius) = 
    let(
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

function _geom_info(tris, radius, detail) = 
    _geom_pts_faces([
        for(tri = tris)
        each [for(t = tri_subdivide(tri, detail)) each t]
    ], radius);

function _geom_info_quick(tris, radius, detail) = 
    let(
        points = [
            for(tri = tris)
            each [for(t = tri_subdivide(tri, detail)) each _geom_prj2sphere(t, radius)]
        ],
        faces = [for(i = [0:3:len(points) - 3]) [i, i + 1, i + 2]]
    )
    [points, faces];

function _geom_platonic_polyhedra(points, faces, radius, detail, quick_mode) = 
    detail == 0 ? [_geom_prj2sphere(points, radius), faces] :
    let(
        tris = [
            for(face = faces)
            [for(i = face) points[i]]
        ]
    )
    quick_mode ? _geom_info_quick(tris, radius, detail) : _geom_info(tris, radius, detail);