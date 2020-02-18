use <polyline2d.scad>;
use <stereographic_extrude.scad>;
use <experimental/mz_blocks.scad>;
use <experimental/mz_get.scad>;

x_cells = 10;
cell_radius = 20;
wall_thickness = 12;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 1;

module build_hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness, left_border = true, bottom_border = true) {
	function no_wall(block) = get_wall_type(block) == "NO_WALL";
	function upper_wall(block) = get_wall_type(block) == "UPPER_WALL";
	function right_wall(block) = get_wall_type(block) == "RIGHT_WALL";
	function upper_right_wall(block) = get_wall_type(block) == "UPPER_RIGHT_WALL";

	function get_x(block) = mz_get(block, "x"); 
	function get_y(block) = mz_get(block, "y");
	function get_wall_type(block) = mz_get(block, "w");

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

	module build_upper_right() { hex_seg(0, 60); }
	module build_upper() { hex_seg(60, 120); }
	module build_upper_left() { hex_seg(120, 180);	}		
	module build_down_left() { hex_seg(180, 240); }
	module build_down() { hex_seg(240, 300); }
	module build_down_right() { hex_seg(300, 360); }	

	module build_cell(block) {
		module build_right_wall(x_cell) {
			if(x_cell % 2 != 0) {
				build_down_right();
			}
			else {
				build_upper_right();
			}
		}

		module build_row_wall(x_cell, y_cell) {
			if(x_cell % 2 != 0) {
				build_upper_right();
				build_upper_left();
			}
			else {
				build_down_right();
			}
		}

		x = get_x(block) - 1;
		y = get_y(block) - 1;

		translate(cell_position(x, y)) {
			build_row_wall(x, y); 

			if(upper_wall(block) || upper_right_wall(block)) {
				build_upper();
			}
			if(right_wall(block) || upper_right_wall(block)) {
				build_right_wall(x);
			}  
		}
		
	}
	
	// create the wall of maze
	for(block = maze_vector) {
		build_cell(block);
	}  

    if(left_border) {
		for(y = [0:y_cells - 1]) {
			translate(cell_position(0, y)) {
				build_upper_left();
				build_down_left();
			}
		}
	}

    if(bottom_border) {
		for(x = [0:x_cells - 1]) {
			translate(cell_position(x, 0)) {
				build_down();
				if(x % 2 == 0) {
					build_down_left();
					build_down_right();
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
    maze_vector = mz_blocks(
        [1, 1],  
        y_cells, x_cells
    );

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