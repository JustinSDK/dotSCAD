function dot_m(dot_pts, leng, m, i = 0) =
    i == leng ? m :
    let(p = dot_pts[i])
    dot_m(dot_pts, leng, updated(p.x, p.y, m), i + 1);

function updated(x, y, dots) =
    let(rowY = dots[y]) 
    [
        for(r = [0:len(dots) - 1])
        if(r == y) [for(c = [0:len(rowY) - 1]) c == x || rowY[c]]
        else dots[r]
    ];
    
function _mz_hamiltonian_top(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2]];

function _mz_hamiltonian_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];
    
function _mz_hamiltonian_top_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2
    )
    [[nx, ny + 2], [nx + 1, ny + 2], [nx + 2, ny + 2], [nx + 2, ny + 1], [nx + 2, ny]];

function _mz_hamiltonian_corner_value(dotM, x, y) =
    let(
        c1 = dotM[y][x] ? 1 : 0,
        c2 = dotM[y + 1][x] ? 2 : 0,
        c3 = dotM[y + 1][x + 1] ? 4 : 0,
        c4 = dotM[y][x + 1] ? 8 : 0
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

function nxtp(dotM, p) = p + _mz_hamiltonian_nxt_offset[_mz_hamiltonian_dir(_mz_hamiltonian_corner_value(dotM, p.x, p.y))];

function _mz_hamiltonian_travel(dotM, p, leng) = 
    let(
        end = leng - 1,
        pts = [
            for(i = 0, nxt_p = nxtp(dotM, p), is_continue = i < end; 
                is_continue && nxt_p != p; 
                i = i + 1,
                is_continue = i < end,
                nxt_p = is_continue ? nxtp(dotM, nxt_p) : undef
            )
            nxt_p
        ]
    )
    [each pts, nxtp(dotM, pts[len(pts) - 1])];
