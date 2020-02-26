use <util/slice.scad>;

function _convex_hull_lt_than_by_xy(p1, p2) =
    p1[0] < p2[0] || (p1[0] == p2[0] && p1[1] < p2[1]);

function _convex_hull_sort_by_xy(lt) = 
    let(leng = len(lt))
    leng <= 1 ? lt : 
        let(
            pivot = lt[0],
            before = [for(j = 1; j < leng; j = j + 1) if(_convex_hull_lt_than_by_xy(lt[j], pivot)) lt[j]],
            after =  [for(j = 1; j < leng; j = j + 1) if(!_convex_hull_lt_than_by_xy(lt[j], pivot)) lt[j]]
        )
        concat(_convex_hull_sort_by_xy(before), [pivot], _convex_hull_sort_by_xy(after));

// oa->ob ct_clk : greater than 0
function _convex_hull_impl_dir(o, a, b) =
    let(
        ox = o[0],
        oy = o[1],
        ax = a[0],
        ay = a[1],
        bx = b[0],
        by = b[1]
    )
    (ax - ox) * (by - oy) - (ay - oy) * (bx - ox);

function _convex_hull_convex_hull_lower_m(chain, p, m) = 
    (m >= 2 && _convex_hull_impl_dir(chain[m - 2], chain[m - 1], p) <= 0) ? _convex_hull_convex_hull_lower_m(chain, p, m - 1) : m;

function _convex_hull_lower_chain(points, leng, chain, m, i) =
    i == leng ? chain : 
        let(
            current_m = _convex_hull_convex_hull_lower_m(chain, points[i], m)
        )
        _convex_hull_lower_chain(
            points,
            leng,
            concat(slice(chain, 0, current_m), [points[i]]),
            current_m + 1,
            i + 1
        );
            
function _convex_hull_upper_m(chain, p, m, t) =
    (m >= t && _convex_hull_impl_dir(chain[m - 2], chain[m - 1], p) <= 0) ?
        _convex_hull_upper_m(chain, p, m - 1, t) : m;
        
function _convex_hull_upper_chain(points, chain, m, t, i) =
    i < 0 ? chain :
        let(
            current_m = _convex_hull_upper_m(chain, points[i], m, t)
        )
        _convex_hull_upper_chain(
            points,
            concat(slice(chain, 0, current_m), [points[i]]),
            current_m + 1,
            t,
            i - 1
        );
