use <polyline2d.scad>
use <stereographic_extrude.scad>
use <maze/mz_square.scad>
use <maze/mz_hexwalls.scad>

columns = 10;
cell_radius = 20;
wall_thickness = 12;
fn = 36;
shadow = "YES"; // [YES, NO]
wall_height = 1;

module hex_maze_stereographic_projection(columns, cell_radius, wall_thickness, fn, wall_height, shadow) {
    rows = round(0.866 * columns - 0.211);

    grid_h = 2 * cell_radius * sin(60);
    grid_w = cell_radius + cell_radius * cos(60);	
    
    square_w = grid_w * (columns - 1) + cell_radius * 2 + wall_thickness * 2;
    square_h = grid_h * rows + grid_h / 2 + wall_thickness * 2;
    square_offset_x = square_w / 2 -cell_radius - wall_thickness;
    square_offset_y = square_h / 2 -grid_h / 2 - wall_thickness;
    
    pyramid_height = square_w / sqrt(2);
  
    // create a maze     
    cells = mz_square(rows, columns);

    walls = mz_hexwalls(cells, cell_radius, wall_thickness);
    
    stereographic_extrude(square_w, $fn = fn, convexity = 10) 
    translate([grid_w - square_w / 2, grid_h - square_w / 2, 0]) 
        for(wall = walls) {
            polyline2d(
                wall, 
                wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
            );    
        }

	if(shadow == "YES") {
		color("black") 
		linear_extrude(wall_height) 
        translate([grid_w - square_w / 2, grid_h - square_w / 2, 0]) 
            for(wall = walls) {
                polyline2d(
                    wall, 
                    wall_thickness,
                    startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
                );    
            }
    }
}

hex_maze_stereographic_projection(columns, cell_radius, wall_thickness, fn, wall_height, shadow);