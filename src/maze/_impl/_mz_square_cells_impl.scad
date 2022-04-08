use <_mz_square_comm.scad>;

// is (x, y) visited?
function visited(x, y, cells) = cells[y][x][3];

// is (x, y) visitable?
function visitable(x, y, cells, rows, columns) = 
    y >= 0 && y < rows &&     // y bound
    x >= 0 && x < columns &&  // x bound
    !visited(x, y, cells);     // unvisited

// setting (x, y) as being visited
function set_visited(x, y, cells) = 
    let(rowY = [for(cell = cells[y]) if(cell.x == x) [x, y, get_type(cell), true] else cell])
    [
        for(r = [0:len(cells) - 1])
        if(r == y) rowY
        else cells[r]
    ];
    
// 0(right), 1(top), 2(left), 3(bottom)
_rand_dir_table = [
    [0, 1, 2, 3],
    [0, 1, 3, 2],
    [0, 2, 1, 3],
    [0, 2, 3, 1],
    [0, 3, 1, 2],
    [0, 3, 2, 1],
    [1, 0, 2, 3],
    [1, 0, 3, 2],
    [1, 2, 0, 3],
    [1, 2, 3, 0],
    [1, 3, 0, 2],
    [1, 3, 2, 0],
    [2, 0, 1, 3],
    [2, 0, 3, 1],
    [2, 1, 0, 3],
    [2, 1, 3, 0],
    [2, 3, 0, 1],
    [2, 3, 1, 0],
    [3, 0, 1, 2],
    [3, 0, 2, 1],
    [3, 1, 0, 2],
    [3, 1, 2, 0],
    [3, 2, 0, 1],
    [3, 2, 1, 0]
];
function rand_dirs(c, seed) =
   let(r = is_undef(seed) ? rands(0, 24, 1) : rands(0, 24, 1, c + seed))
    _rand_dir_table[round(r[0])]; 

// get x value by dir
_next_x_table = [1, 0, -1, 0];
function next_x(x, dir, columns, wrapping) = 
    let(nx = x + _next_x_table[dir])
    wrapping ? (nx + columns) % columns : nx;
    
// get y value by dir
_next_y_table = [0, 1, 0, -1];
function next_y(y, dir, rows, wrapping) = 
    let(ny = y + _next_y_table[dir])
    wrapping ? (ny + rows) % rows : ny;
    
// go right and carve the right wall
function carve_right(x, y, cells) = 
    let(
        rowY = [
            for(cell = cells[y]) 
            if(cell.x != x) cell
            else (top_right_wall(cell) ? [x, y, 1, true] : [x, y, 0, true]) 
        ]
    )
    [
        for(r = [0:len(cells) - 1])
        if(r == y) rowY
        else cells[r]
    ];

// go up and carve the top wall
function carve_top(x, y, cells) = 
    let(
        rowY = [
            for(cell = cells[y]) 
            if(cell.x != x) cell
            else (top_right_wall(cell) ? [x, y, 2, true] : [x, y, 0, true]) 
        ]
    )
    [
        for(r = [0:len(cells) - 1])
        if(r == y) rowY
        else cells[r]
    ];

// go left and carve the right wall of the left cell
function carve_left(x, y, cells, columns) = 
    let(
        x_minus_one = x - 1,
        nx = x_minus_one < 0 ? x_minus_one + columns : x_minus_one,
        rowY = [
            for(cell = cells[y]) 
            if(cell.x != nx) cell
            else [nx, y, 1, false]
        ]
    )
    [
        for(r = [0:len(cells) - 1])
        if(r == y) rowY
        else cells[r]
    ];

// go down and carve the top wall of the bottom cell
function carve_bottom(x, y, cells, rows) = 
    let(
        y_minus_one = y - 1,
        ny = y_minus_one < 0 ? y_minus_one + rows : y_minus_one,
        rowNY = [
            for(cell = cells[ny]) 
            if(cell.x != x) cell
            else [x, ny, 2, false]
        ]
    )
    [
        for(r = [0:len(cells) - 1])
        if(r == ny) rowNY
        else cells[r]
    ];

// 0(right), 1(top), 2(left), 3(bottom)
function carve(dir, x, y, cells, rows, columns) =
    dir == 0 ? carve_right(x, y, cells) : 
    dir == 1 ? carve_top(x, y, cells) : 
    dir == 2 ? carve_left(x, y, cells, columns) : 
    /*dir 3*/  carve_bottom(x, y, cells, rows);

// find out visitable dirs from (x, y)
function visitable_dirs(r_dirs, x, y, cells, rows, columns, x_wrapping, y_wrapping) = [
    for(dir = r_dirs) 
    if(visitable(next_x(x, dir, columns, x_wrapping), next_y(y, dir, rows, y_wrapping), cells, rows, columns)) 
        dir
];  
    
// go maze from (x, y)
function go_maze(x, y, cells, rows, columns, x_wrapping = false, y_wrapping = false, seed) = 
    let(
        r_dirs = rand_dirs(x + y * columns, seed),
        v_dirs = visitable_dirs(r_dirs, x, y, cells, rows, columns, x_wrapping, y_wrapping),
        nxcells0 = set_visited(x, y, cells),
        leng_v_dirs = len(v_dirs)
    )
    //  have visitable dirs?
    leng_v_dirs == 0 ? nxcells0 :      // road closed
    // try four directions
    let(nxcells1 = next_cells(x, y, v_dirs[0], nxcells0, rows, columns, x_wrapping, y_wrapping, seed))
    leng_v_dirs == 1 ? nxcells1 :
    let(nxcells2 = next_cells(x, y, v_dirs[1], nxcells1, rows, columns, x_wrapping, y_wrapping, seed))
    leng_v_dirs == 2 ? nxcells2 : 
    let(nxcells3 = next_cells(x, y, v_dirs[2], nxcells2, rows, columns, x_wrapping, y_wrapping, seed))
    leng_v_dirs == 3 ? nxcells3 : next_cells(x, y, v_dirs[3], nxcells3, rows, columns, x_wrapping, y_wrapping, seed);

function next_cells(x, y, dir, cells, rows, columns, x_wrapping, y_wrapping, seed) =
    let(
        nx = next_x(x, dir, columns, x_wrapping),
        ny = next_y(y, dir, rows, y_wrapping)
    )
    !visitable(nx, ny, cells, rows, columns) ? // is the dir visitable?
            cells :   // road closed so return cells directly
            go_maze(  // try the cell 
                nx, ny, 
                carve(dir, x, y, cells, rows, columns),
                rows, columns,
                x_wrapping, y_wrapping,
                seed
            );