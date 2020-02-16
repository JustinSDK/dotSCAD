use <square_maze.scad>;

maze_rows = 8;
block_width = 10;
stairs_width = 5;

module pyramid_with_stairs(base_width, stairs_width, rows) {
    height = base_width * sqrt(2) / 2;

    module layer(i) {
        base_w = base_width - (base_width / rows) * (i - 1) + stairs_width;
        floor_h = height / rows * 2;
                
        stairsteps = rows;
        staircase_h = floor_h / stairsteps;
        staircase_w = stairs_width / stairsteps * 2;
        
        translate([0, 0, floor_h / 2 * (i - 1)]) 
            for(j = [1:stairsteps]) {
                square_w = base_w - j * staircase_w;
                translate([0, 0, staircase_h * (j - 1)])  
                linear_extrude(staircase_h) 
                    square([square_w, square_w], center = true);
            }
    }
    
    for(i = [1:2:rows - 1]) {
        layer(i);
    }
}

module step_pyramid_maze(maze_rows, block_width, stairs_width) {    
    intersection() {
        pyramid_with_stairs(
            maze_rows * block_width, stairs_width, maze_rows);

        linear_extrude(maze_rows * block_width * sqrt(2) / 2)  difference() {
            
            square([block_width * maze_rows + stairs_width, block_width * maze_rows + stairs_width], center = true);
            
            translate([-(maze_rows * block_width) / 2, -(maze_rows * block_width) / 2, 0]) 
            difference() {
                square_maze([1, 1], maze_rows, block_width, stairs_width);

                // entry
                translate([0, stairs_width]) 
                    square(stairs_width, center = true);

                // exit
                translate([maze_rows * block_width, maze_rows * block_width - stairs_width]) 
                    square(stairs_width, center = true);
            }
        }
    }
}

step_pyramid_maze(maze_rows, block_width, stairs_width);