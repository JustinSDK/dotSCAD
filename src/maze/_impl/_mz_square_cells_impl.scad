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
    wrapping ? (nx < 0 ? nx + columns : nx % columns) : nx;
    
// get y value by dir
_next_y_table = [0, 1, 0, -1];
function next_y(y, dir, rows, wrapping) = 
    let(ny = y + _next_y_table[dir])
    wrapping ? (ny < 0 ? ny + rows : ny % rows) : ny;
    
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
        r_dirs = rand_dirs(x * rows + y, seed),
        v_dirs = visitable_dirs(r_dirs, x, y, cells, rows, columns, x_wrapping, y_wrapping),
        nx_cells = set_visited(x, y, cells)
    )
    //  have visitable dirs?
    v_dirs == [] ? nx_cells      // road closed
        : walk_around_from(          
            x, y, 
            v_dirs,             
            nx_cells, 
            rows, columns,
            x_wrapping, y_wrapping,
            len(v_dirs) - 1,
            seed = seed
        );

// try four directions
function walk_around_from(x, y, dirs, cells, rows, columns, x_wrapping, y_wrapping, i, seed) =
    // all done?
    i == -1 ? cells :
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[i], cells, rows, columns, x_wrapping, y_wrapping, seed),  
            rows, columns, 
            x_wrapping, y_wrapping,
            i - 1,
            seed);
        
function try_routes_from(x, y, dir, cells, rows, columns, x_wrapping, y_wrapping, seed) = 
    // is the dir visitable?
    !visitable(next_x(x, dir, columns, x_wrapping), next_y(y, dir, rows, y_wrapping), cells, rows, columns) ?
        // road closed so return cells directly
        cells :     
        // try the cell 
        go_maze(
            next_x(x, dir, columns, x_wrapping), next_y(y, dir, rows, y_wrapping), 
            carve(dir, x, y, cells, rows, columns),
            rows, columns,
            x_wrapping, y_wrapping,
            seed
        ); 