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
    
function _top(x, y) =
    let(nx = x * 2, ny_2 = y * 2 + 2)
    [for(i = [0:2]) [nx + i, ny_2]];

function _right(x, y) =
    let(nx_2 = x * 2 + 2, ny = y * 2)
    [for(i = [2, 1, 0]) [nx_2, ny + i]];
    
function _top_right(x, y) =
    let(
        nx = x * 2,
        ny = y * 2,
        nx_2 = nx + 2,
        ny_2 = ny + 2
    )
    [[nx, ny_2], [nx + 1, ny_2], [nx_2, ny_2], [nx_2, ny + 1], [nx_2, ny]];

function _corner_value(dotM, x, y) =
    let(
        dotMy = dotM[y],
        dotMy1 = dotM[y + 1],
        x_1 = x + 1,
        c1 = dotMy[x] ? 1 : 0,
        c2 = dotMy1[x] ? 2 : 0,
        c3 = dotMy1[x_1] ? 4 : 0,
        c4 = dotMy[x_1] ? 8 : 0
    )
    c1 + c2 + c3 + c4;

_dir_table = [
    [4,  0], [12, 0], [13, 0], // UP
    [1,  1], [3,  1], [7,  1], // DOWN
    [2,  2], [6,  2], [14, 2], // LEFT
    [8,  3], [9,  3], [11, 3]  // RIGHT
];

_nxt_offset = [
    [0,  1],  // UP
    [0, -1],  // DOWN
    [-1, 0],  // LEFT
    [1,  0]   // RIGHT
];

function nxtp(dotM, p) = p + _nxt_offset[lookup(_corner_value(dotM, p.x, p.y), _dir_table)];

function _travel(dotM, p, leng) = 
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
