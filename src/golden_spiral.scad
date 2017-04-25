/**
* archimedean_spiral.scad
*
*  Gets all points and angles on the path of an archimedean_spiral. The distance between two  points is almost constant. 
* 
*  It returns a vector of [[x, y], angle]. 
*
*  In polar coordinates (r, �c) Archimedean spiral can be described by the equation r = b�c where
*  �c is measured in radians. For being consistent with OpenSCAD, the function here use degrees.
*
*  An init_angle less than 180 degrees is not recommended because the function uses an approximate 
*  approach. If you really want an init_angle less than 180 degrees, a larger arm_distance 
*  is required. To avoid a small error value at the calculated distance between two points, you 
*  may try a smaller point_distance.
* 
* @copyright Justin Lin, 2017
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib-archimedean_spiral.html
*
**/ 

function _radian_step(b, theta, l) =
    let(r_square = pow(b * theta, 2))
    acos((2 * r_square - pow(l, 2)) / (2 * r_square)) / 180 * 3.14159;

function _find_radians(b, point_distance, radians, n, count = 1) =
    let(pre_radians = radians[count - 1])
    count == n ? radians : (
        _find_radians(
            b, 
            point_distance, 
            concat(
                radians,
                [pre_radians + _radian_step(b, pre_radians, point_distance)]
            ), 
            n,
        count + 1) 
    );

/* 
    In polar coordinates (r, �c) Archimedean spiral can be described by the equation r = b�c where
    �c is measured in radians. For being consistent with OpenSCAD, the function here use degrees.
    An init_angle angle less than 180 degrees is not recommended because the function uses an 
    approximate approach. If you really want an angle less than 180 degrees, a larger arm_distance 
    is required. To avoid a small error value at the calculated distance between two points, you 
    may try a smaller point_distance.
*/

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
        arc_points = [
            for(pt = circle_path(radius = f1, n = $fn / 4 + 1))
                [pt[0], pt[1], 0] // to 3D points because of rotate_p
        ],
        offset = f2 - f1
    ) _remove_same_pts(
        arc_points, 
        [
            for(pt = _golden_spiral(from + 1, to, point_distance)) 
                rotate_p(pt, [0, 0, 90]) + [0, -offset, 0]
        ]
    );

function _golden_spiral(from, to, point_distance) = 
    from <= to ? 
        _golden_spiral_from_ls_or_eql_to(from, to, point_distance) : [];

function golden_spiral(from, to, point_distance) =    
    [
        for(pt = _golden_spiral(from, to, point_distance)) 
            [pt[0], pt[1]]  // to 2D points
    ];    