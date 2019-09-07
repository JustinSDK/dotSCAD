include <hull_polyline3d.scad>;
include <rotate_p.scad>;
include <square_maze.scad>;

rows = 8;
columns = 16;
block_width = 2;
wall_thickness = 1;   
angle = 90;
// $fn = 24;

function block_walls(block, block_width) = 
    let(
        loc = [get_x(block) - 1, get_y(block) - 1] * block_width,
        wall_type = get_wall_type(block),
        upper_wall = wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL ? [[0, block_width] + loc, [block_width, block_width] + loc] : [],
        right_wall = wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL ? [[block_width, block_width] + loc, [block_width, 0] + loc] : []
    )
    concat(
        upper_wall, 
        right_wall
    ); 
  
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
    
function x_twist(walls, angle, rows, columns, block_width) = 
    let(
        y_offset = rows * block_width / 2,
        y_centered = [
            for(wall_pts = walls) 
                [for(pt = wall_pts) [pt[0], pt[1], 0] + [0, -y_offset, 0]]
        ],
        a_step = angle / columns
    )
    [
        for(wall_pts = y_centered)    
           [
               for(pt = wall_pts)
                   rotate_p(pt, [pt[0] * a_step, 0, 0]) + [0, y_offset, 0]
           ]
    ];

blocks = go_maze( 
    1, 1,   // starting point
    starting_maze(rows, columns),  
    rows, columns
);
    
walls = maze_walls(blocks, rows, columns, block_width);

for(wall_pts = x_twist(walls, angle, rows, columns, block_width)) {   
   hull_polyline3d(wall_pts, wall_thickness);
}