use <../../lines_intersection.scad>
use <_convex_ct_clk_order.scad>
use <../../util/set/hashset.scad>
use <../../util/set/hashset_elems.scad>

include <../../__comm__/_pt2_hash.scad>

function _in_convex_r(convex_pts, pt, leng, i = 0) =
    let(j = i + 1)
    j == leng || 
	cross(convex_pts[i] - pt, convex_pts[j] - pt) > 0 && 
    _in_convex_r(convex_pts, pt, leng, j);

function _in_convex(convex_pts, pt) = 
    let(leng = len(convex_pts))
    // all counter-clockwise?
    cross(convex_pts[leng - 1] - pt, convex_pts[0] - pt) > 0 &&
	_in_convex_r(
        convex_pts, 
        pt, 
        leng
    );
	
function _intersection_ps(closed_shape, line_pts, epsilon) = 
    let(
        npts = [
            for(i = [0:len(closed_shape) - 2]) 
            let(p = lines_intersection(line_pts, [closed_shape[i], closed_shape[i + 1]], epsilon = epsilon))
            if(p != []) p
        ],
        leng = len(npts)
    )
    leng < 2 ? npts : 
    leng == 2 ? (npts[0] != npts[1] ? npts : [npts[0]]) :
    hashset_elems(hashset(npts, hash = _pt2_hash));

function _convex_intersection(shape1, shape2, epsilon = 0.0001) =
    (shape1 == [] || shape2 == []) ? [] :
    let(closed_shape2 = [each shape2, shape2[0]])
    _convex_ct_clk_order(
        concat(
            [for(p = shape1) if(_in_convex(shape2, p)) p], 
            [for(p = shape2) if(_in_convex(shape1, p)) p],
            [for(i = [0:len(shape1) - 2]) each _intersection_ps(closed_shape2, [shape1[i], shape1[i + 1]], epsilon)],
            _intersection_ps(closed_shape2, [shape1[len(shape1) - 1], shape1[0]], epsilon)
        )
    );  