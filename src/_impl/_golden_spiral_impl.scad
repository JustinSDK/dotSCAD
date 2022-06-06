use <../__comm__/__fast_fibonacci.scad>
use <../shape_circle.scad>
    
function _remove_same_pts(pts1, pts2) = 
    concat(
        pts1,
        pts1[len(pts1) - 1] == pts2[0] ? [for(i = [1:len(pts2) - 1]) pts2[i]] : pts2
    );

function _rz_matrix(a) = 
    let(c = cos(a), s = sin(a)) 
    [
        [c, -s],
        [s,  c],
    ];  
    
function _from_ls_or_eql_to(from, to, point_distance, rt_dir) = 
    let(
        f1 = __fast_fibonacci(from),
        fn = floor(f1 * PI * 2 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = shape_circle(radius = f1, n = $fn / 4 + 1),
        len_pts_1 = len(circle_pts) - 1,
        a_step = 360 / $fn * rt_dir,
        range_i = [0:len_pts_1],
        as = [each range_i] * a_step,
        c_idx = rt_dir == 1 ? function(i) i : function(i) len_pts_1 - i,

        d_f1f2 = f1 - __fast_fibonacci(from + 1),
        off_p = rt_dir == 1 ? [0, d_f1f2, 0] : [d_f1f2, 0, 0],
        za =  90 * rt_dir,
        m = _rz_matrix(za)
    ) _remove_same_pts(
        [for(i = range_i) [circle_pts[c_idx(i)], as[i]]], 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
            [ 
                m * pt_a[0] + off_p, 
                pt_a[1] + za
            ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from > to ? [] : _from_ls_or_eql_to(from, to, point_distance, rt_dir);
 
function _golden_spiral_impl(from, to, point_distance, rt_dir) =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));