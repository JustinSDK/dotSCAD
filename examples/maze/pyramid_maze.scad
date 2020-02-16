use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;

maze_rows = 10;
block_width = 2;
wall_thickness = 1;

module pyramid_maze(maze_rows, block_width, wall_thickness) {
    module pyramid(leng) {
        height = leng / 1.4142135623730950488016887242097;
        linear_extrude(height, scale = 0) 
            square(leng, center = true);
    }
    
    blocks = mz_blocks(
        [1, 1],  
        maze_rows, maze_rows
    );

    walls = mz_walls(blocks, maze_rows, maze_rows, block_width);

    leng = maze_rows * block_width ;
    half_leng = leng / 2;
    
    intersection() {
        linear_extrude(leng * 2) 
        translate([-half_leng, -half_leng]) 
        for(wall = walls) {
            for(i = [0:len(wall) - 2]) {
                hull() {
                    translate(wall[i]) square(wall_thickness, center = true);
                    translate(wall[i + 1]) square(wall_thickness, center = true);
                }
            }
        }        
        
        pyramid(leng + wall_thickness);
    }
}

pyramid_maze(maze_rows, block_width, wall_thickness);