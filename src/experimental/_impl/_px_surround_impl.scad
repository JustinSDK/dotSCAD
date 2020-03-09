use <experimental/has.scad>;

function _px_surround_corner_value(pts, x, y) =
    let(
        c1 = has(pts, [x, y - 1]) || has(pts, [x - 1, y - 1]) ? 1 : 0,
        c2 = has(pts, [x - 1, y]) || has(pts, [x - 1, y + 1]) ? 2 : 0,
        c3 = has(pts, [x, y + 1]) || has(pts, [x + 1, y + 1]) ? 4 : 0,
        c4 = has(pts, [x + 1, y]) || has(pts, [x + 1, y - 1]) ? 8 : 0
    )
    c1 + c2 + c3 + c4;

_px_surround_dir_table = [
    [4,  0], [6,  0], [7, 0],    // RIGHT
    [8,  1], [12, 1], [14, 1],   // DOWN
    [2,  2], [3,  2], [11, 2],   // UP
    [1,  3], [9,  3], [13, 3]    // LEFT
];
function _px_surround_dir(cr_value) = 
    lookup(cr_value, _px_surround_dir_table);

_px_surround_nxt_offset = [
    [1,  0],   // RIGHT
    [0, -1],   // DOWN
    [0,  1],   // UP
    [-1, 0]    // LEFT
];
function _px_surround_travel(pts, p, fst) = 
    let(
        dir_i = _px_surround_dir(_px_surround_corner_value(pts, p[0], p[1])),
        nxt_p = p + _px_surround_nxt_offset[dir_i]
    )
    nxt_p == fst ? [p] :
    concat(
        [p], _px_surround_travel(pts, nxt_p, fst)
    );
