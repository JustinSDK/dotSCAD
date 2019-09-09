// NO_WALL = 0;       
// UPPER_WALL = 1;    
// RIGHT_WALL = 2;    
// UPPER_RIGHT_WALL = 3; 

function no_wall(block_data) = get_wall_type(block_data) == 0;
function upper_wall(block_data) = get_wall_type(block_data) == 1;
function right_wall(block_data) = get_wall_type(block_data) == 2;
function upper_right_wall(block_data) = get_wall_type(block_data) == 3;

function block_data(x, y, wall_type, visited) = [x, y, wall_type, visited];
function get_x(block_data) = block_data[0];
function get_y(block_data) = block_data[1];
function get_wall_type(block_data) = block_data[2];

// create a starting maze for being visited later.
function starting_maze(rows, columns) =  [
    for(y = [1:rows]) 
        for(x = [1:columns]) 
            block_data(
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
    
// 0(right)、1(upper)、2(left)、3(down)
function rand_dirs() =
    [
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
    ][round(rands(0, 24, 1)[0])]; 

// get x value by dir
function next_x(x, dir, columns, circular) = 
    let(nx = x + [1, 0, -1, 0][dir])
    circular ? 
        nx < 1 ? nx + columns : (
            nx > columns ? nx % columns : nx
        )
        :
        nx;
    
// get y value by dir
function next_y(y, dir, rows, circular) = 
    let(ny = y + [0, 1, 0, -1][dir])
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

// 0(right)、1(upper)、2(left)、3(down)
function try_block(dir, x, y, maze, rows, columns) =
    dir == 0 ? go_right_from(x, y, maze) : (
        dir == 1 ? go_up_from(x, y, maze) : (
            dir == 2 ? go_left_from(x, y, maze, columns) : 
                 go_down_from(x, y, maze, rows)   // dir is 3
            
        ) 
    );


// find out visitable dirs from (x, y)
function visitable_dirs_from(x, y, maze, rows, columns, x_circular, y_circular) = [
    for(dir = [0, 1, 2, 3]) 
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

module build_square_maze(rows, columns, blocks, block_width, wall_thickness, left_border = true, bottom_border = true) {
    module build_block(block, block_width, wall_thickness) {
        translate([get_x(block) - 1, get_y(block) - 1] * block_width) {
            if(upper_wall(block) || upper_right_wall(block)) {
                // draw a upper wall
                line2d(
                    [0, block_width], [block_width, block_width], wall_thickness
                ); 
            }
            
            if(right_wall(block) || upper_right_wall(block)) {
                // draw a right wall
                line2d(
                    [block_width, block_width], [block_width, 0], wall_thickness
                ); 
            }
        }
    }
    
    for(block = blocks) {
        build_block(
            block, 
            block_width, 
            wall_thickness
        );
    }

    if(left_border) {
        line2d([0, 0], [0, block_width * rows], wall_thickness);
    }

    if(bottom_border) {
        line2d([0, 0], [block_width * columns, 0], wall_thickness);
    }
}         

function block_walls(block, block_width) = 
    let(
        loc = [get_x(block) - 1, get_y(block) - 1] * block_width,
        upper = upper_wall(block) || upper_right_wall(block) ? [[0, block_width] + loc, [block_width, block_width] + loc] : [],
        right = right_wall(block) || upper_right_wall(block) ? [[block_width, block_width] + loc, [block_width, 0] + loc] : []
    )
    concat(upper, right); 
  
function maze_walls(blocks, rows, columns, block_width, left_border = true, bottom_border = true) = 
    let(
        left_walls = left_border ? [for(y = [0:rows - 1]) [[0, block_width * (y + 1)], [0, block_width * y]]] : [],
        buttom_walls = bottom_border ? [for(x = [0:columns - 1]) [[block_width * x, 0], [block_width * (x + 1), 0]]] : []
    )
     concat(
        [
            for(block = blocks) 
            let(pts = block_walls(block, block_width))
            if(pts != []) pts
        ]
        , left_walls, buttom_walls
    );
    
function y_twist(walls, angle, rows, columns, block_width) = 
    let(
        x_offset = columns * block_width / 2,
        x_centered = [
            for(wall_pts = walls) 
                [for(pt = wall_pts) [pt[0], pt[1], 0] + [-x_offset, 0, 0]]
        ],
        a_step = angle / (rows * block_width)
    )
    [
        for(wall_pts = x_centered)    
           [
               for(pt = wall_pts)
                   rotate_p(pt, [0, pt[1] * a_step, 0]) + [x_offset, 0, 0]
           ]
    ];