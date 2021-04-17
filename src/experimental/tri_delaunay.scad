use <experimental/_impl/_tri_delaunay_impl.scad>;

// ret: "TRI_SHAPES", "TRI_INDICES", "DELAUNAY"
function tri_delaunay(points, ret = "TRI_SHAPES") = 
    let(
		xs = [for(p = points) p[0]],
		ys = [for(p = points) p[1]],
		max_x = max(xs),
		min_x = min(xs),
		max_y = max(ys),
		min_y = min(ys),
		center = [max_x + min_x, max_y + min_y] / 2,
		width = abs(max_x - center[0]) * 4,
		height = abs(max_y - center[1]) * 4,
        d = _tri_delaunay(delaunay_init(center, width, height), points, len(points))
    )
    ret == "TRI_SHAPES" ?  tri_delaunay_shapes(d) : 
    ret == "TRI_INDICES" ? tri_delaunay_indices(d) :
    d; // "DELAUNAY": [coords(list), triangles(hashmap), circles(hashmap)]