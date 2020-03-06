use <experimental/_impl/_mz_comm.scad>;

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block(
                x, y, 
                // all blocks have upper and right walls
                3, 
                // unvisited
                false 
            )
];

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
    
// 0(right), 1(upper), 2(left), 3(down)
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
function rand_dirs() =
    _rand_dir_table[round(rands(0, 24, 1)[0])]; 

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
function go_right_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        upper_right_wall(b) ? 
            [x, y, 1, visited(x, y, maze)] : 
            [x, y, 0, visited(x, y, maze)]
        
    ) : b
]; 

// go up and carve the upper wall
function go_up_from(x, y, maze) = [
    for(b = maze) [get_x(b), get_y(b)] == [x, y] ? (
        upper_right_wall(b) ? 
            [x, y, 2, visited(x, y, maze)] :  
            [x, y, 0, visited(x, y, maze)]
        
    ) : b
]; 

// go left and carve the right wall of the left block
function go_left_from(x, y, maze, columns) = 
    let(
        x_minus_one = x - 1,
        nx = x_minus_one < 1 ? x_minus_one + columns : x_minus_one
    )
    [
        for(b = maze) [get_x(b), get_y(b)] == [nx, y] ? (
            upper_right_wall(b) ? 
                [nx, y, 1, visited(nx, y, maze)] : 
                [nx, y, 0, visited(nx, y, maze)]
        ) : b
    ]; 

// go down and carve the upper wall of the down block
function go_down_from(x, y, maze, rows) = [
    let(
        y_minus_one = y - 1,
        ny = y_minus_one < 1 ? y_minus_one + rows : y_minus_one
    )
    for(b = maze) [get_x(b), get_y(b)] == [x, ny] ? (
        upper_right_wall(b) ? 
            [x, ny, 2, visited(x, ny, maze)] : 
            [x, ny, 0, visited(x, ny, maze)]
    ) : b
]; 

// 0(right), 1(upper), 2(left), 3(down)
function try_block(dir, x, y, maze, rows, columns) =
    dir == 0 ? go_right_from(x, y, maze) : 
    dir == 1 ? go_up_from(x, y, maze) : 
    dir == 2 ? go_left_from(x, y, maze, columns) : 
    /*dir 3*/  go_down_from(x, y, maze, rows);


// find out visitable dirs from (x, y)
_visitable_dir_table = [0, 1, 2, 3];
function visitable_dirs_from(x, y, maze, rows, columns, x_circular, y_circular) = [
    for(dir = _visitable_dir_table) 
        if(visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns)) 
            dir
];  
    
// go maze from (x, y)
function go_maze(x, y, maze, rows, columns, x_circular = false, y_circular = false) = 
    //  have visitable dirs?
    len(visitable_dirs_from(x, y, maze, rows, columns, x_circular, y_circular)) == 0 ? 
        set_visited(x, y, maze)      // road closed
        : walk_around_from(          
            x, y, 
            rand_dirs(),             
            set_visited(x, y, maze), 
            rows, columns,
            x_circular, y_circular
        );

// try four directions
function walk_around_from(x, y, dirs, maze, rows, columns, x_circular, y_circular, i = 4) =
    // all done?
    i > 0 ? 
        // not yet
        walk_around_from(x, y, dirs, 
            // try one direction
            try_routes_from(x, y, dirs[4 - i], maze, rows, columns, x_circular, y_circular),  
            rows, columns, 
            x_circular, y_circular,
            i - 1) 
        : maze;
        
function try_routes_from(x, y, dir, maze, rows, columns, x_circular, y_circular) = 
    // is the dir visitable?
    visitable(next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), maze, rows, columns) ?     
        // try the block 
        go_maze(
            next_x(x, dir, columns, x_circular), next_y(y, dir, rows, y_circular), 
            try_block(dir, x, y, maze, rows, columns),
            rows, columns,
            x_circular, y_circular
        ) 
        // road closed so return maze directly
        : maze; 