use <../../util/has.scad>;

function _mz_wang_tiles_top(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 1, ny + 2]];

function _mz_wang_tiles_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 2, ny + 1]];
    
function _mz_wang_tiles_top_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 1, ny + 2], [nx + 2, ny + 1]];

function _mz_wang_tile_type(dots, x, y) =
    let(
        px = x * 2 + 1,
        py = y * 2 + 1,
        c1 = !has(dots, [px, py + 1], sorted = true) ? 1 : 0,
        c2 = !has(dots, [px + 1, py], sorted = true) ? 2 : 0,
        c3 = !has(dots, [px, py - 1], sorted = true) ? 4 : 0,
        c4 = !has(dots, [px - 1, py], sorted = true) ? 8 : 0
    )
    c1 + c2 + c3 + c4;
