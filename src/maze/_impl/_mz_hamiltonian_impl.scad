use <util/has.scad>;

function _mz_hamiltonian_upper(x, y) =
    let(
        nx = (x - 1) * 2,
        ny = (y - 1) * 2
    )
    [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2]];

function _mz_hamiltonian_right(x, y) =
    let(
        nx = (x - 1) * 2,
        ny = (y - 1) * 2
    )
    [[nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];
    
function _mz_hamiltonian_upper_right(x, y) =
    let(
        nx = (x - 1) * 2,
        ny = (y - 1) * 2
    )
    [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];

function _mz_hamiltonian_corner_value(dots, x, y) =
    let(
        c1 = has(dots, [x, y], sorted = true) ? 1 : 0,
        c2 = has(dots, [x, y + 1], sorted = true) ? 2 : 0,
        c3 = has(dots, [x + 1, y + 1], sorted = true) ? 4 : 0,
        c4 = has(dots, [x + 1, y], sorted = true) ? 8 : 0
    )
    c1 + c2 + c3 + c4;

_mz_hamiltonian_dir_table = [
    [4,  0], [12, 0], [13, 0], // UP
    [1,  1], [3,  1], [7,  1], // DOWN
    [2,  2], [6,  2], [14, 2], // LEFT
    [8,  3], [9,  3], [11, 3]  // RIGHT
];
function _mz_hamiltonian_dir(cr_value) = 
    lookup(cr_value, _mz_hamiltonian_dir_table);

_mz_hamiltonian_nxt_offset = [
    [0,  1],  // UP
    [0, -1],  // DOWN
    [-1, 0],  // LEFT
    [1,  0]   // RIGHT
];
function _mz_hamiltonian_travel(dot_pts, p, leng, i = 0) = 
    i == leng ? [] :
    let(
        dir_i = _mz_hamiltonian_dir(_mz_hamiltonian_corner_value(dot_pts, p[0], p[1])),
        nxt_p = p + _mz_hamiltonian_nxt_offset[dir_i]
    )
    concat(
        [p], _mz_hamiltonian_travel(dot_pts, nxt_p, leng, i + 1)
    );
