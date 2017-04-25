/**
* golden_spiral.scad
*
*  Gets all points and angles on the path of a golden spiral. The distance between two  points is almost constant. 
* 
*  It returns a vector of [[x, y], angle]. 
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-golden_spiral.html
*
**/ 

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
        concat(pts1, [for(i = [1:len(pts2) - 1]) pts2[i]]) : 
        concat(pts1, pts2);    

function _golden_spiral_from_ls_or_eql_to(from, to, point_distance ) = 
    let(
        f1 = _fast_fibonacci(from),
        f2 = _fast_fibonacci(from + 1),
        fn = floor(f1 * 6.28312 / point_distance), 
        $fn = fn + 4 - (fn % 4),
        arc_points_angles = [
            for(pt = circle_path(radius = f1, n = $fn / 4 + 1))
                [[pt[0], pt[1], 0], 0] // to 3D points because of rotate_p
        ],
        offset = f2 - f1
    ) _remove_same_pts(
        arc_points_angles, 
        [
            for(pt_a = _golden_spiral(from + 1, to, point_distance)) 
                [rotate_p(pt_a[0], [0, 0, 90]) + [0, -offset, 0], pt_a[1] + 90]
        ]
    ); 

function _golden_spiral(from, to, point_distance) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance) : [];

function golden_spiral(from, to, point_distance) =    
    [
        for(pt_a = _golden_spiral(from, to, point_distance)) 
            [[pt_a[0][0], pt_a[0][1]], pt_a[1]]  // to 2D points
    ];    