use <maze/mz_square_cells.scad>;
use <maze/mz_square_walls.scad>;

module square_maze(rows, cell_width, wall_thickness) {
    cells = mz_square_cells(
        rows, rows
    );

    walls = mz_square_walls(cells, rows, rows, cell_width);

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
    cell_width = 2, 
    wall_thickness = 1
);