use <experimental/_impl/_convex_hull_impl.scad>;

function convex_hull(points) = 
    let(
        sorted = _convex_hull_sort_by_xy(points),
        leng = len(sorted),
        lwr_ch = _convex_hull_lower_chain(sorted, leng, [], 0, 0),
        leng_lwr_ch = len(lwr_ch),
        chain = _convex_hull_upper_chain(sorted, lwr_ch, leng_lwr_ch, leng_lwr_ch + 1, leng - 2)
    )
    [for(i = [0:len(chain) - 2]) chain[i]];