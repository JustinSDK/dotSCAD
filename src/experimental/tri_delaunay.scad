use<experimental/_impl/_tri_delaunay_impl.scad>;

// ret: "SHAPES", "INDICES", "DELAUNAY"
function tri_delaunay(points, ret = "SHAPES") = 
    let(d = _tri_delaunay(delaunay_init(points), points, len(points)))
    ret == "SHAPES" ?  tri_delaunay_shapes(d) : 
    ret == "INDICES" ? tri_delaunay_indices(d) :
    d; // [coords(list), triangles(hashmap), circles(hashmap)]