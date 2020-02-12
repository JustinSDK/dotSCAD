use <hull_polyline3d.scad>;
use <rotate_p.scad>;
use <square_maze.scad>;

rows = 16;
columns = 8;
block_width = 4;
wall_thickness = 1;   
angle = 180;
// $fn = 24;

function tf_twist(size, p, ) =

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

blocks = go_maze( 
    1, 1,   // starting point
    starting_maze(rows, columns),  
    rows, columns
);
    
walls = maze_walls(blocks, rows, columns, block_width);
for(wall_pts = y_twist(walls, angle, rows, columns, block_width)) {   
   hull_polyline3d(wall_pts, wall_thickness);
}