use <../__comm__/__fast_fibonacci.scad>;
use <../ptf/ptf_rotate.scad>;
use <../shape_circle.scad>;
    
function _remove_same_pts(pts1, pts2) = 
    concat(
        pts1,
        pts1[len(pts1) - 1] == pts2[0] ? [for(i = [1:len(pts2) - 1]) pts2[i]] : pts2
    );

function _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) = 
    let(
        f1 = __fast_fibonacci(from),
        f2 = __fast_fibonacci(from + 1),
        fn = floor(f1 * PI * 2 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = shape_circle(radius = f1, n = $fn / 4 + 1),
        len_pts = len(circle_pts),
        a_step = 360 / $fn * rt_dir,
        range_i = [0:len_pts - 1],
        arc_points_angles = (
            rt_dir == 1 ? 
                [for(i = range_i) [circle_pts[i], a_step * i]] : 
                [for(i = range_i) let(idx = len_pts - i - 1) [circle_pts[idx], a_step * i]]
        ),
        d_f2f1 = f2 - f1,
        off_p = rt_dir == 1 ? [0, -d_f2f1, 0] : [-d_f2f1, 0, 0],
        za =  90 * rt_dir,
        ra = [0, 0, za]
    ) _remove_same_pts(
        arc_points_angles, 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
            [ 
                ptf_rotate(pt_a[0], ra) + off_p, 
                pt_a[1] + za
            ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) : [];
 
function _golden_spiral_impl(from, to, point_distance, rt_dir) =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));