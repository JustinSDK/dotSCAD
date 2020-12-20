use <_mz_comm.scad>;

// find out the index of a cell with the position (x, y)
function indexOf(x, y, cells, i = 0) =
    i == len(cells) ? -1 : (
        [get_x(cells[i]), get_y(cells[i])] == [x, y] ? i : 
            indexOf(x, y, cells, i + 1)
    );

// is (x, y) visited?
function visited(x, y, cells) = cells[indexOf(x, y, cells)][3];

// is (x, y) visitable?
function visitable(x, y, cells, rows, columns) = 
    y >= 0 && y < rows &&     // y bound
    x >= 0 && x < columns &&  // x bound
    !visited(x, y, cells);     // unvisited

// setting (x, y) as being visited
function set_visited(x, y, cells) = [
    for(cell = cells) 
        [x, y] == [get_x(cell), get_y(cell)] ? 
            [x, y, get_type(cell), true] : cell
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
function carve_right(x, y, cells) = [
    for(cell = cells) [get_x(cell), get_y(cell)] == [x, y] ? (
        top_right_wall(cell) ? [x, y, 1, 1] :  [x, y, 0, 1]
    ) : cell
]; 

// go up and carve the top wall
function carve_top(x, y, cells) = [
    for(cell = cells) [get_x(cell), get_y(cell)] == [x, y] ? (
        top_right_wall(cell) ? [x, y, 2, 1] : [x, y, 0, 1]
    ) : cell
]; 

// go left and carve the right wall of the left cell
function carve_left(x, y, cells, columns) = 
    let(
        x_minus_one = x - 1,
        nx = x_minus_one < 0 ? x_minus_one + columns : x_minus_one
    )
    [for(cell = cells) [get_x(cell), get_y(cell)] == [nx, y] ? [nx, y, 1, 0] : cell]; 

// go down and carve the top wall of the bottom cell
function carve_bottom(x, y, cells, rows) = 
    let(
        y_minus_one = y - 1,
        ny = y_minus_one < 0 ? y_minus_one + rows : y_minus_one
    )
    [for(cell = cells) [get_x(cell), get_y(cell)] == [x, ny] ? [x, ny, 2, 0] : cell]; 

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
        v_dirs = visitable_dirs(r_dirs, x, y, cells, rows, columns, x_wrapping, y_wrapping)
    )
    //  have visitable dirs?
    len(v_dirs) == 0 ? 
        set_visited(x, y, cells)      // road closed
        : walk_around_from(          
            x, y, 
            v_dirs,             
            set_visited(x, y, cells), 
            rows, columns,
            x_wrapping, y_wrapping,
            seed = seed
        );

// try four directions
function walk_around_from(x, y, dirs, cells, rows, columns, x_wrapping, y_wrapping, i = 0, seed) =
    // all done?
    i < len(dirs) ? 
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[i], cells, rows, columns, x_wrapping, y_wrapping, seed),  
            rows, columns, 
            x_wrapping, y_wrapping,
            i + 1,
            seed) 
        : cells;
        
function try_routes_from(x, y, dir, cells, rows, columns, x_wrapping, y_wrapping, seed) = 
    // is the dir visitable?
    visitable(next_x(x, dir, columns, x_wrapping), next_y(y, dir, rows, y_wrapping), cells, rows, columns) ?     
        // try the cell 
        go_maze(
            next_x(x, dir, columns, x_wrapping), next_y(y, dir, rows, y_wrapping), 
            carve(dir, x, y, cells, rows, columns),
            rows, columns,
            x_wrapping, y_wrapping,
            seed
        ) 
        // road closed so return cells directly
        : cells; 