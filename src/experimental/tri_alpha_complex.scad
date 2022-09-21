include <__comm__/_pt2_hash.scad>
use <triangle/tri_delaunay.scad>
use <triangle/tri_delaunay_indices.scad>
use <triangle/tri_circumcenter.scad>
use <util/map/hashmap.scad>
use <util/map/hashmap_get.scad>
use <util/map/hashmap_put.scad>
use <util/map/hashmap_entries.scad>
use <util/has.scad>

function circumcircle_rr(shape_pts) =
   let(
	  center = tri_circumcenter(shape_pts),
	  v = shape_pts[0] - center
   )
   v * v;
   
function edge(a, b) = a < b ? [a, b] : [b, a];   

function dist_gt(p1, p2, leng) = let(v = p2 - p1) v * v > leng ^ 2;

function edge_tri(indices_tris, m, i = 0) = 
    len(indices_tris) == i ? m :
    let(
        t_indices = indices_tris[i],
        
        edge1 = edge(t_indices[0], t_indices[1]),
        t_lt1 = hashmap_get(m, edge1, hash = _pt2_hash),
        m1 = hashmap_put(m, edge1, is_undef(t_lt1) ? [t_indices] : [each t_lt1, t_indices], hash = _pt2_hash),
        
        edge2 = edge(t_indices[1], t_indices[2]),
        t_lt2 = hashmap_get(m1, edge2, hash = _pt2_hash),
        m2 = hashmap_put(m1, edge2, is_undef(t_lt2) ? [t_indices] : [each t_lt2, t_indices], hash = _pt2_hash),
        
        edge3 = edge(t_indices[2], t_indices[0]),
        t_lt3 = hashmap_get(m2, edge3, hash = _pt2_hash)
    )
    edge_tri(indices_tris, hashmap_put(m2, edge3, is_undef(t_lt3) ? [t_indices] : [each t_lt3, t_indices], hash = _pt2_hash), i + 1);

function reduce_tris(indices_tris, dist) = 
    let(
        m = edge_tri(indices_tris, hashmap(number_of_buckets = len(indices_tris) / 4)),  
        entries = hashmap_entries(m), 
        edges = [
            for(entry = entries)  
            if(len(entry[1]) == 1 && dist_gt(points[entry[0][0]], points[entry[0][1]], dist))
            entry[0]
        ],
        reduce_tris = [
            for(t_indices = indices_tris) 
            let(
                edge1 = edge(t_indices[0], t_indices[1]),
                edge2 = edge(t_indices[1], t_indices[2]),
                edge3 = edge(t_indices[2], t_indices[0])
            )
            if(
                !has(edges, edge1) && !has(edges, edge2) && !has(edges, edge3)
            )
            t_indices
        ]
    )
    len(indices_tris) > len(reduce_tris) ? reduce_tris(reduce_tris, dist) : reduce_tris;

function tri_alpha_complex(points, dist, d) = 
    reduce_tris(is_undef(d) ? tri_delaunay(points) : tri_delaunay_indices(d), dist);
   
dist = 30;
seed = 101;
points = [for(i = [0:150]) rands(-100, 100, 2, seed_value = seed + i)]; 

d = tri_delaunay(points, ret = "DELAUNAY");
convex_hull_tris = tri_delaunay_indices(d);
concave_hull_tris = tri_alpha_complex(points, dist, d); 

for(t = concave_hull_tris) {
    offset(-.2)
    polygon([for(i = t) points[i]]);
}

%for(t = convex_hull_tris) {
    offset(-.2)
    polygon([for(i = t) points[i]]);
}

color("red")
for(p = points) {
    translate(p)
    circle(2);
}
