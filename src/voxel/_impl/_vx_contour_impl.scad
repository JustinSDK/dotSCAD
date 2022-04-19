use <../../util/set/hashset.scad>;
use <../../util/set/hashset_has.scad>;

include <../../__comm__/_pt2_hash.scad>;

hash = function(p) _pt2_hash(p);

function _vx_contour_corner_value(pts, x, y) =
    let(
        c1 = hashset_has(pts, [x, y - 1], hash = _pt2_hash) || hashset_has(pts, [x - 1, y - 1], hash = _pt2_hash) ? 1 : 0,
        c2 = hashset_has(pts, [x - 1, y], hash = _pt2_hash) || hashset_has(pts, [x - 1, y + 1], hash = _pt2_hash) ? 2 : 0,
        c3 = hashset_has(pts, [x, y + 1], hash = _pt2_hash) || hashset_has(pts, [x + 1, y + 1], hash = _pt2_hash) ? 4 : 0,
        c4 = hashset_has(pts, [x + 1, y], hash = _pt2_hash) || hashset_has(pts, [x + 1, y - 1], hash = _pt2_hash) ? 8 : 0
    )
    c1 + c2 + c3 + c4;

_vx_contour_dir_table = [
    [4,  0], [6,  0], [7, 0],    // RIGHT
    [8,  1], [12, 1], [14, 1],   // DOWN
    [2,  2], [3,  2], [11, 2],   // UP
    [1,  3], [9,  3], [13, 3]    // LEFT
];
function _vx_contour_dir(cr_value) = 
    lookup(cr_value, _vx_contour_dir_table);

function _vx_contour(points) = 
    let(
        // always start from the left-bottom pt
        fst = min(points) + [-1, -1]
    )
    _vx_contour_travel(hashset(points, hash = _pt2_hash), fst, fst);

_vx_contour_nxt_offset = [
    [1,  0],   // RIGHT
    [0, -1],   // DOWN
    [0,  1],   // UP
    [-1, 0]    // LEFT
];
function _vx_contour_travel(pts, p, fst) = 
    let(
        dir_i = _vx_contour_dir(_vx_contour_corner_value(pts, p.x, p.y)),
        nxt_p = p + _vx_contour_nxt_offset[dir_i]
    )
    nxt_p == fst ? [p] : [p, each _vx_contour_travel(pts, nxt_p, fst)];
