/**
   copy from triangulate.scad, would move into triangle category
**/

use <experimental/_impl/_tri_ear_clipping_impl.scad>;

// ret: "TRI_SHAPES", "TRI_INDICES"
function tri_ear_clipping(shape_pts,  ret = "TRI_INDICES", epsilon = 0.0001) = 
    let(tris = _tri_ear_clipping_impl(shape_pts,  epsilon))
    ret == "TRI_INDICES" ? tris : [for(tri = tris) [for(idx = tri) shape_pts[idx]]];