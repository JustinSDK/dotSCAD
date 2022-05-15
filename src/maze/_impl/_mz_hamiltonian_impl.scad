function dot_m(dot_pts, leng, m, i = 0) =
    i == leng ? m :
    dot_m(dot_pts, leng, updated(dot_pts[i], m), i + 1);

function updated(p, dots) =
    let(x = p.x, y = p.y, rowY = dots[y]) 
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

function _corner_value(dotM, p) =
    let(
        x = p.x, 
        y = p.y,
        dotMy = dotM[y],
        dotMy1 = dotM[y + 1],
        x_1 = x + 1
    )
    (dotMy[x] ?    1 : 0) + 
    (dotMy1[x] ?   2 : 0) + 
    (dotMy1[x_1] ? 4 : 0) + 
    (dotMy[x_1] ?  8 : 0);

UP = [0,  1];
DOWN = [0, -1];
LEFT = [-1, 0]; 
RIGHT = [1,  0]; 

_dir_table = [
    undef, DOWN,  LEFT,  DOWN,
    UP,    undef, LEFT,  DOWN,
    RIGHT, RIGHT, undef, RIGHT,
    UP,    UP,    LEFT,  undef
];

function nxtp(dotM, p) = p + _dir_table[_corner_value(dotM, p)];

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
