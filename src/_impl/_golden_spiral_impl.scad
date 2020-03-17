use <__comm__/__fast_fibonacci.scad>;
use <rotate_p.scad>;
use <shape_circle.scad>;

function _fast_fibonacci_sub(nth) = 
    let(
        _f = _fast_fibonacci_2_elems(floor(nth / 2)),
        a = _f[0],
        b = _f[1],
        c = a * (b * 2 - a),
        d = a * a + b * b
    ) 
    nth % 2 == 0 ? [c, d] : [d, c + d];

function _fast_fibonacci_2_elems(nth) =
    nth == 0 ? [0, 1] : _fast_fibonacci_sub(nth);
    
function _fast_fibonacci(nth) =
    _fast_fibonacci_2_elems(nth)[0];
    
function _remove_same_pts(pts1, pts2) = 
    pts1[len(pts1) - 1] == pts2[0] ? 
        concat(pts1, [for(i = 1; i < len(pts2); i = i + 1) pts2[i]]) : 
        concat(pts1, pts2);    

function _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) = 
    let(
        f1 = __fast_fibonacci(from),
        f2 = __fast_fibonacci(from + 1),
        fn = floor(f1 * 6.28312 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        circle_pts = shape_circle(radius = f1, n = $fn / 4 + 1),
        len_pts = len(circle_pts),
        a_step = 360 / $fn * rt_dir,
        range_i = [0:len_pts - 1],
        arc_points_angles = (rt_dir == 1 ? [
            for(i = range_i)
                [circle_pts[i], a_step * i] 
        ] : [
            for(i = range_i) let(idx = len_pts - i - 1)
                [circle_pts[idx], a_step * i] 
        ]),
        offset = f2 - f1
    ) _remove_same_pts(
        arc_points_angles, 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance, rt_dir)) 
                [ 
                    rotate_p(pt_a[0], [0, 0, 90 * rt_dir]) + 
                    (rt_dir == 1 ? [0, -offset, 0] : [-offset, 0, 0]), 
                    pt_a[1] + 90 * rt_dir
                ]
        ] 
    ); 

function _golden_spiral(from, to, point_distance, rt_dir) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance, rt_dir) : [];
 
function _golden_spiral_impl(from, to, point_distance, rt_dir) =    
    _golden_spiral(from, to, point_distance, (rt_dir == "CT_CLK" ? 1 : -1));