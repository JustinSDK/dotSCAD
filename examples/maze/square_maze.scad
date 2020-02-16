use <experimental/mz_blocks.scad>;
use <experimental/mz_walls.scad>;

module square_maze(start, rows, block_width, wall_thickness) {
    blocks = mz_blocks(
        start,  
        rows, rows
    );

    walls = mz_walls(blocks, rows, rows, block_width);

    for(wall = walls) {
        for(i = [0:len(wall) - 2]) {
            hull() {
                translate(wall[i]) square(wall_thickness, center = true);
                translate(wall[i + 1]) square(wall_thickness, center = true);
            }
        }
    } 
}

square_maze(
    start = [1, 1], 
    rows = 10, 
    block_width = 2, 
    wall_thickness = 1
);