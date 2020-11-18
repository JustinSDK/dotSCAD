use <_mz_comm.scad>;

// find out the index of a block with the position (x, y)
function indexOf(x, y, maze, i = 0) =
    i > len(maze) ? -1 : (
        [get_x(maze[i]), get_y(maze[i])] == [x, y] ? i : 
            indexOf(x, y, maze, i + 1)
    );

// is (x, y) visited?
function visited(x, y, maze) = maze[indexOf(x, y, maze)][3];

// is (x, y) visitable?
function visitable(x, y, maze, rows, columns) = 
    y > 0 && y <= rows &&     // y bound
    x > 0 && x <= columns &&  // x bound
    !visited(x, y, maze);     // unvisited

// setting (x, y) as being visited
function set_visited(x, y, maze) = [
    for(b = maze) 
        [x, y] == [get_x(b), get_y(b)] ? 
            [x, y, get_wall_type(b), true] : b
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
function rand_dirs(seed) =
   let(r = is_undef(seed) ? rands(0, 24, 1) : rands(0, 24, 1, seed))
    _rand_dir_table[round(r[0])]; 

// get x value by dir
_next_x_table = [1, 0, -1, 0];
function next_x(x, dir, columns, circular) = 
    let(nx = x + _next_x_table[dir])
    circular ? 
        nx < 1 ? nx + columns : (
            nx > columns ? nx % columns : nx
        )
        :
        nx;
    
// get y value by dir
_next_y_table = [0, 1, 0, -1];
function next_y(y, dir, rows, circular) = 
    let(ny = y + _next_y_table[dir])
    circular ? 
        ny < 1 ? ny + rows : (
            ny > rows ? ny % rows : ny
        )
        :
        ny;
    
// go right and carve the right wall
function carve_right(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        top_right_wall(b) ? [x, y, 1, 1] :  [x, y, 0, 1]
    ) : b
]; 

// go up and carve the top wall
function carve_top(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        top_right_wall(b) ? [x, y, 2, 1] : [x, y, 0, 1]
    ) : b
]; 

// go left and carve the right wall of the left block
function carve_left(x, y, maze, columns) = 
    let(
        x_minus_one = x - 1,
        nx = x_minus_one < 1 ? x_minus_one + columns : x_minus_one
    )
    [for(b = maze) [get_x(b), get_y(b)] == [nx, y] ? [nx, y, 1, 0] : b]; 

// go down and carve the top wall of the bottom block
function carve_bottom(x, y, maze, rows) = 
    let(
        y_minus_one = y - 1,
        ny = y_minus_one < 1 ? y_minus_one + rows : y_minus_one
    )
    [for(b = maze) [get_x(b), get_y(b)] == [x, ny] ? [x, ny, 2, 0] : b]; 

// 0(right), 1(top), 2(left), 3(bottom)
function carve(dir, x, y, maze, rows, columns) =
    dir == 0 ? carve_right(x, y, maze) : 
    dir == 1 ? carve_top(x, y, maze) : 
    dir == 2 ? carve_left(x, y, maze, columns) : 
    /*dir 3*/  carve_bottom(x, y, maze, rows);


// find out visitable dirs from (x, y)
function visitable_dirs(r_dirs, x, y, maze, rows, columns, x_circular, y_circular) = [
    for(dir = r_dirs) 
        if(visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns)) 
            dir
];  
    
// go maze from (x, y)
function go_maze(x, y, maze, rows, columns, x_circular = false, y_circular = false, seed) = 
    let(
        r_dirs = rand_dirs(x * rows + y + seed),
        v_dirs = visitable_dirs(r_dirs, x, y, maze, rows, columns, x_circular, y_circular)
    )
    //  have visitable dirs?
    len(v_dirs) == 0 ? 
        set_visited(x, y, maze)      // road closed
        : walk_around_from(          
            x, y, 
            v_dirs,             
            set_visited(x, y, maze), 
            rows, columns,
            x_circular, y_circular,
            seed = seed
        );

// try four directions
function walk_around_from(x, y, dirs, maze, rows, columns, x_circular, y_circular, i = 0, seed) =
    // all done?
    i < len(dirs) ? 
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[i], maze, rows, columns, x_circular, y_circular, seed),  
            rows, columns, 
            x_circular, y_circular,
            i + 1,
            seed) 
        : maze;
        
function try_routes_from(x, y, dir, maze, rows, columns, x_circular, y_circular, seed) = 
    // is the dir visitable?
    visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns) ?     
        // try the block 
        go_maze(
            next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), 
            carve(dir, x, y, maze, rows, columns),
            rows, columns,
            x_circular, y_circular,
            seed
        ) 
        // road closed so return maze directly
        : maze; 