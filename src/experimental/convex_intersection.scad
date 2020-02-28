
use <in_shape.scad>;
use <experimental/_impl/_convex_intersection_impl.scad>;
use <experimental/convex_ct_clk_order.scad>;

function convex_intersection(shape1, shape2, epsilon = 0.0001) =
    (shape1 == [] || shape2 == []) ? [] :
    let(
        leng = len(shape1),
        pts = concat(shape1, [shape1[0]])
    )
    convex_ct_clk_order(
        concat(
            [for(p = shape1) if(in_shape(shape2, p, include_edge = true)) p], 
            [for(p = shape2) if(in_shape(shape1, p, include_edge = true)) p],
            [for(i = [0:leng - 1]) each _intersection_ps(shape2, [pts[i], pts[i + 1]], epsilon)] 
        )
    );  