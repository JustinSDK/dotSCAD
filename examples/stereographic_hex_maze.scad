include <line2d.scad>;
include <polyline2d.scad>;
include <stereographic_extrude.scad>;
include <square_maze.scad>;

x_cells = 10;
cell_radius = 20;
wall_thickness = 12;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 1;

// build a hex maze
module build_hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness, left_border = true, bottom_border = true) {
	function cell_position(x_cell, y_cell) =
		let(
			grid_h = 2 * cell_radius * sin(60),
			grid_w = cell_radius + cell_radius * cos(60)
		)
		[grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0];

    module hex_seg(begin, end) {
		polyline2d(
			[for(a = [begin:60:end]) 
				[cell_radius * cos(a), cell_radius * sin(a)]], 
			wall_thickness,
			startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
		);
	}

	module up_right_wall() { hex_seg(0, 60); }
	module upper_wall() { hex_seg(60, 120); }
	module up_left_wall() { hex_seg(120, 180);	}		
	module down_left_wall() { hex_seg(180, 240); }
	module down_wall() { hex_seg(240, 300); }
	module down_right_wall() { hex_seg(300, 360); }	

	module build_cell(x, y, wall_type) {
		module build_right_wall(x_cell) {
			if(x_cell % 2 != 0) {
				down_right_wall();
			}
			else {
				up_right_wall();
			}
		}

		module build_row_wall(x_cell, y_cell) {
			if(x_cell % 2 != 0) {
				up_right_wall();
				up_left_wall();
			}
			else {
				down_right_wall();
			}
		}

		build_row_wall(x, y); 

		if(wall_type == UPPER_WALL || wall_type == UPPER_RIGHT_WALL) {
			upper_wall();
		}
		if(wall_type == RIGHT_WALL || wall_type == UPPER_RIGHT_WALL) {
			build_right_wall(x);
		}  
	}
	
	// create the wall of maze
	for(cell = maze_vector) {
		x = cell[0] - 1;
		y = cell[1] - 1;
		wall_type = cell[2];
        translate(cell_position(x, y)) {
			build_cell(x, y, wall_type);
		}
	}  

    if(left_border) {
		for(y = [0:y_cells - 1]) {
			translate(cell_position(0, y)) {
				up_left_wall();
				down_left_wall();
			}
		}
	}

    if(bottom_border) {
		for(x = [0:x_cells - 1]) {
			translate(cell_position(x, 0)) {
				down_wall();
				if(x % 2 == 0) {
					down_left_wall();
					down_right_wall();
				}
			}
		}	
	}
}

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