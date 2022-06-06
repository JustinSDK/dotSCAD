use <../util/slice.scad>
use <../util/sorted.scad>

// oa->ob ct_clk : greater than 0
function _convex_hull_impl_dir(o, a, b) = cross(a - o, b - o);

function _convex_hull_convex_hull_lower_m(chain, p, m) = 
    (m < 2 || _convex_hull_impl_dir(chain[m - 2], chain[m - 1], p) > 0) ? m : _convex_hull_convex_hull_lower_m(chain, p, m - 1);

function _convex_hull_lower_chain(points, leng, chain, m, i) =
    i == leng ? chain : 
        let(current_m = _convex_hull_convex_hull_lower_m(chain, points[i], m))
        _convex_hull_lower_chain(
            points,
            leng,
            [each slice(chain, 0, current_m), points[i]],
            current_m + 1,
            i + 1
        );
            
function _convex_hull_upper_m(chain, p, m, t) =
    (m < t || _convex_hull_impl_dir(chain[m - 2], chain[m - 1], p) > 0) ? m : _convex_hull_upper_m(chain, p, m - 1, t);
        
function _convex_hull_upper_chain(points, chain, m, t, i) =
    let(current_m = _convex_hull_upper_m(chain, points[i], m, t))
    i == 2 ? slice(chain, 0, current_m) :
        _convex_hull_upper_chain(
            points,
            [each slice(chain, 0, current_m), points[i]],
            current_m + 1,
            t,
            i - 1
        );

function _convex_hull2(points) = 
    let(
        sorted_pts = sorted(points),
        leng = len(sorted_pts),
        lwr_ch = _convex_hull_lower_chain(sorted_pts, leng, [], 0, 0),
        leng_lwr_ch = len(lwr_ch)
    )
    _convex_hull_upper_chain(sorted_pts, lwr_ch, leng_lwr_ch, leng_lwr_ch + 1, leng - 2);