use<experimental/_impl/_tri_delaunay_impl.scad>;

// ret: "TRI_SHAPES", "TRI_INDICES", "DELAUNAY"
// todo: "VORONOI_SHAPES"
function tri_delaunay(points, ret = "TRI_SHAPES") = 
    let(d = _tri_delaunay(delaunay_init(points), points, len(points)))
    ret == "TRI_SHAPES" ?  tri_delaunay_shapes(d) : 
    ret == "TRI_INDICES" ? tri_delaunay_indices(d) :
    d; // [coords(list), triangles(hashmap), circles(hashmap)]