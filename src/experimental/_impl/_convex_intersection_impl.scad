use <lines_intersection.scad>;

function _intersection_ps(shape, line_pts, epsilon) = 
    let(
        leng = len(shape),
        pts = [each shape, shape[0]]
    )
    [
        for(i = [0:leng - 1]) 
        let(p = lines_intersection(line_pts, [pts[i], pts[i + 1]], epsilon = epsilon))
        if(p != []) p
    ];