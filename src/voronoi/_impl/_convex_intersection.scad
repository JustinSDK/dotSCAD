
use <../../in_shape.scad>;
use <../../lines_intersection.scad>;
use <_convex_ct_clk_order.scad>;

function _intersection_ps(shape, line_pts, epsilon) = 
    let(
        leng = len(shape),
        pts = concat(shape, [shape[0]])
    )
    [
        for(i = [0:leng - 1]) 
        let(p = lines_intersection(line_pts, [pts[i], pts[i + 1]], epsilon = epsilon))
        if(p != []) p
    ];

function _convex_intersection(shape1, shape2, epsilon = 0.0001) =
    (shape1 == [] || shape2 == []) ? [] :
    let(
        leng = len(shape1),
        pts = concat(shape1, [shape1[0]])
    )
    _convex_ct_clk_order(
        concat(
            [for(p = shape1) if(in_shape(shape2, p, include_edge = true)) p], 
            [for(p = shape2) if(in_shape(shape1, p, include_edge = true)) p],
            [for(i = [0:leng - 1]) each _intersection_ps(shape2, [pts[i], pts[i + 1]], epsilon)] 
        )
    );  