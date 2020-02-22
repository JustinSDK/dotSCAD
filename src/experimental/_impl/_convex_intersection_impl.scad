use <experimental/intersection_p.scad>;

function _intersection_ps(shape, line_pts, epsilon) = 
    let(
        leng = len(shape),
        pts = concat(shape, [shape[0]])
    )
    [
        for(i = [0:leng - 1]) 
        let(p = intersection_p(line_pts, [pts[i], pts[i + 1]], epsilon = epsilon))
        if(p != []) p
    ];