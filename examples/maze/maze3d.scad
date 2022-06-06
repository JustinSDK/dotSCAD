use <maze/mz_cube.scad>
use <maze/mz_cube_get.scad>
use <util/contains.scad>
use <crystal_ball.scad>

layers = 4;
rows = 4;
columns = 4;
cell_width = 15;
road_width = 9;
$fn = 4;  // [4, 8, 12]

maze3d();

module maze3d() {
    cells = mz_cube(layers, rows, columns);
    draw_3dmaze(cells, cell_width, road_width);
}

module draw_3dmaze(cells, cell_width, road_width) {
    layers = len(cells);
    rows = len(cells[0]);
    columns = len(cells[0][0]);

    for(z = [0:layers - 1], y = [0:rows - 1], x = [0:columns - 1]) {
        cell = cells[z][y][x];
        type = mz_cube_get(cell, "t");
        
        if(type != "MASK") {
            channels = [
                z_road(type) ,
                z != 0 && z_road(mz_cube_get(cells[z - 1][y][x], "t")),
                y_road(type),
                x_road(type),
                y != 0 && y_road(mz_cube_get(cells[z][y - 1][x], "t")),
                x != 0 && x_road(mz_cube_get(cells[z][y][x - 1], "t"))
            ];
            
            translate([x, y, z] * cell_width)
                drawCell(cell_width, road_width, channels);
        }
    }

    function z_road(type) = !contains(["Z_WALL", "Z_Y_WALL", "Z_X_WALL", "Z_Y_X_WALL", "MASK"], type);

    function y_road(type) = !contains(["Y_WALL", "Y_X_WALL", "Z_Y_WALL", "Z_Y_X_WALL", "MASK"], type);

    function x_road(type) = !contains(["X_WALL", "Y_X_WALL", "Z_X_WALL", "Z_Y_X_WALL", "MASK"], type);

    module drawCell(cell_width, road_width, channels) {
        half_cw = cell_width / 2;
        half_rw = road_width / 2;

        crystal_ball(half_rw);

        rots = [
            [0, 0, 0],
            [180, 0, 0],
            [-90, 0, 0],
            [0, 90, 0],
            [90, 0, 0],
            [0, -90, 0]
        ];
        
       for(i = [0:5]) {
            if(channels[i]) {
                rotate(rots[i])
                linear_extrude(half_cw)
                    circle(half_rw);
            }
        }
    }
}