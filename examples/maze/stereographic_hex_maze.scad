use <stereographic_extrude.scad>;
use <square_maze.scad>;

x_cells = 10;
cell_radius = 20;
wall_thickness = 12;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 1;

module hex_maze_stereographic_projection(x_cells, cell_radius, wall_thickness, fn, wall_height, shadow) {
    y_cells = round(0.866 * x_cells - 0.211);

    grid_h = 2 * cell_radius * sin(60);
    grid_w = cell_radius + cell_radius * cos(60);	
    
    square_w = grid_w * (x_cells - 1) + cell_radius * 2 + wall_thickness * 2;
    square_h = grid_h * y_cells + grid_h / 2 + wall_thickness * 2;
    square_offset_x = square_w / 2 -cell_radius - wall_thickness;
    square_offset_y = square_h / 2 -grid_h / 2 - wall_thickness;
    
    pyramid_height = square_w / sqrt(2);
  
    // create a maze     
    maze_vector = go_maze(1, 1, starting_maze(y_cells, x_cells), y_cells, x_cells);

    stereographic_extrude(square_w, $fn = fn) 
    translate([grid_w - square_w / 2, grid_h - square_w / 2, 0]) 
        build_hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness);

	if(shadow == "YES") {
		color("black") 
		linear_extrude(wall_height) 
        translate([grid_w - square_w / 2, grid_h - square_w / 2, 0]) 
            build_hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness);
    }
}

hex_maze_stereographic_projection(x_cells, cell_radius, wall_thickness, fn, wall_height, shadow);