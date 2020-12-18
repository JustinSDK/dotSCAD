use <maze/mz_square_blocks.scad>;
use <maze/mz_square_walls.scad>;

module square_maze(rows, block_width, wall_thickness) {
    blocks = mz_square_blocks(
        rows, rows
    );

    walls = mz_square_walls(blocks, rows, rows, block_width);

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
    rows = 10, 
    block_width = 2, 
    wall_thickness = 1
);