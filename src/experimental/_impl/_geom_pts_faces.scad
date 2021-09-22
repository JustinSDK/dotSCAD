use <__comm__/_pt3_hash.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_put.scad>;
use <util/map/hashmap_get.scad>;

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