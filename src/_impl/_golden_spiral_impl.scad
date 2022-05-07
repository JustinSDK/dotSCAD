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
        fn = floor(f1 * PI * 2 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = shape_circle(radius = f1, n = $fn / 4 + 1),
        d_f1f2 = f1 - __fast_fibonacci(from + 1),
        off_p = rt_dir == 1 ? [0, d_f1f2, 0] : [d_f1f2, 0, 0],
        za =  90 * rt_dir,
        ra = [0, 0, za],
        len_pts_1 = len(circle_pts) - 1,
        as = [each [0:len_pts_1]] * (360 / $fn * rt_dir),
        range = rt_dir == 1 ? [0:len_pts_1] : [len_pts_1:-1:-1]
    ) _remove_same_pts(
        [for(i = range) [circle_pts[i], as[i]]], 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
            [ 
                ptf_rotate(pt_a[0], ra) + off_p, 
                pt_a[1] + za
            ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from > to ? [] : _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir);
 
function _golden_spiral_impl(from, to, point_distance, rt_dir) =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));