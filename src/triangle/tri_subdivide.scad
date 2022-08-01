use <_impl/_tri_subdivide_impl.scad>
    
function tri_subdivide(shape_pts, n) =
    n == 0 ? [shape_pts] :
    let(
        pts = _tri_subdivide_pts(shape_pts, n),
        indices = _tri_subdivide_indices(n)
    )
    [
        for(ti = indices) 
        [pts[ti[0]], pts[ti[1]], pts[ti[2]]]
    ];
    