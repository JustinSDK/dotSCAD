use <../../util/set/hashset_has.scad>

include <../../__comm__/_pt2_hash.scad>

function _mz_tiles_top(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 1, ny + 2]];

function _mz_tiles_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 2, ny + 1]];
    
function _mz_tiles_top_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 1, ny + 2], [nx + 2, ny + 1]];

hash = function(p) _pt2_hash(p);
function _mz_tile_type(dots, x, y) =
    let(
        px = x * 2 + 1,
        py = y * 2 + 1,
        c1 = !hashset_has(dots, [px, py + 1], hash = hash) ? 1 : 0,
        c2 = !hashset_has(dots, [px + 1, py], hash = hash) ? 2 : 0,
        c3 = !hashset_has(dots, [px, py - 1], hash = hash) ? 4 : 0,
        c4 = !hashset_has(dots, [px - 1, py], hash = hash) ? 8 : 0
    )
    c1 + c2 + c3 + c4;
