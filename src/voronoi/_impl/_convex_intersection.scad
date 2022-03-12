
use <../../util/dedup.scad>;
use <../../lines_intersection.scad>;
use <_convex_ct_clk_order.scad>;

function _in_convex_r(i, j, preC, convex_pts, pt, leng, convex_pts, pt) =
    j == leng || (
		let(c = cross(convex_pts[i] - pt, convex_pts[j] - pt))
		c * preC > 0 && _in_convex_r(j, j + 1, c, convex_pts, pt, leng, convex_pts, pt)
    );

function _in_convex(convex_pts, pt) = 
    let(
	    leng = len(convex_pts),
		c = cross(convex_pts[leng - 1] - pt, convex_pts[0] - pt)
    )
	_in_convex_r(0, 1, c, convex_pts, pt, leng, convex_pts, pt);
	

function _intersection_ps(shape, line_pts, epsilon) = 
    let(pts = [each shape, shape[0]])
    dedup([
        for(i = [0:len(shape) - 1]) 
        let(p = lines_intersection(line_pts, [pts[i], pts[i + 1]], epsilon = epsilon))
        if(p != []) p
    ]);

function _convex_intersection(shape1, shape2, epsilon = 0.0001) =
    (shape1 == [] || shape2 == []) ? [] :
    let(pts = [each shape1, shape1[0]])
    _convex_ct_clk_order(
        concat(
            [for(p = shape1) if(_in_convex(shape2, p)) p], 
            [for(p = shape2) if(_in_convex(shape1, p)) p],
            [for(i = [0:len(shape1) - 1]) each _intersection_ps(shape2, [pts[i], pts[i + 1]], epsilon)] 
        )
    );  