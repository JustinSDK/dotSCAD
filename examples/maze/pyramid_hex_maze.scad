use <polyline2d.scad>
use <maze/mz_square.scad>
use <maze/mz_hexwalls.scad>

columns = 10;
cell_radius = 2;
wall_thickness = 1;

module pyramid_hex_maze(columns, cell_radius, wall_thickness) {
    module bottom(rows, columns, cell_radius, wall_thickness) {
        grid_h = 2 * cell_radius * sin(60);
        grid_w = cell_radius + cell_radius * cos(60);	
        for(x_cell = [0:columns - 1], (y_cell = [0:rows - 1]) {
            translate([grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0])  
                circle(cell_radius + wall_thickness, $fn = 6);
        }
    }

    rows = round(0.866 * columns - 0.211);

    grid_h = 2 * cell_radius * sin(60);
    grid_w = cell_radius + cell_radius * cos(60);	
    
    square_w = grid_w * (columns - 1) + cell_radius * 2 + wall_thickness * 2;
    square_h = grid_h * rows + grid_h / 2 + wall_thickness * 2;
    square_offset_x = square_w / 2 -cell_radius - wall_thickness;
    square_offset_y = square_h / 2 -grid_h / 2 - wall_thickness;
    
    pyramid_height = square_w / sqrt(2);

    cells = mz_square(rows, columns);
    walls = mz_hexwalls(cells, cell_radius, wall_thickness);

    intersection() {    
        linear_extrude(pyramid_height) 
        for(wall = walls) {
            polyline2d(
                wall, 
                wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
            );    
        }

        translate([square_offset_x, square_offset_y, 0]) 
        linear_extrude(pyramid_height, scale = 0) 
            square([square_w, square_h], center = true);       
    }
        
    linear_extrude(wall_thickness)
        bottom(rows, columns, cell_radius, wall_thickness);
        
}

pyramid_hex_maze(columns, cell_radius, wall_thickness);    