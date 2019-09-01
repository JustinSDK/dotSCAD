include <line2d.scad>;
include <polyline2d.scad>;
include <stereographic_extrude.scad>;
include <square_maze.scad>;

x_cells = 5;
cell_radius = 20;
wall_thickness = 12;
fn = 24;
shadow = "YES"; // [YES, NO]
wall_height = 1;

// create a maze
module hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness) {

	// style : upper/rights/right
	module cell(x_cell, y_cell, style) {
		module upper_wall() {
			polyline2d(
				[for(a = [60:60:120]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			);
		}
		
		module down_wall() {
			polyline2d(
				[for(a = [240:60:300]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			);
		}
		
		module up_left_wall() {
			polyline2d( 
				[for(a = [120:60:180]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			); 
		}
		
		module down_left_wall() {
			polyline2d( 
				[for(a = [180:60:240]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			);  
		}
		
		module up_right_wall() {
			polyline2d(
				[for(a = [0:60:60]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			); 
		}
		
		module down_right_wall() {
			polyline2d( 
				[for(a = [300:60:360]) 
					[cell_radius * cos(a), cell_radius * sin(a)]], 
				wall_thickness,
                startingStyle = "CAP_ROUND", endingStyle = "CAP_ROUND"
			);
		}
		
		module right_walls() {
			up_right_wall();
			down_right_wall();
		}
		
		module cell_border_wall() {
			if(x_cell == 0) {
				up_left_wall();
				down_left_wall();
			}

			if(x_cell == x_cells - 1 && y_cell == y_cells - 1) {
				up_right_wall();
			}

            if(y_cell == 0) {
				down_wall();
				if(x_cell % 2 == 0) {
					if(x_cell != 0) {
					    down_left_wall();
					}
					down_right_wall();
				}
			}
		
			if(y_cell == y_cells - 1 && x_cell % 2 != 0) {
				up_left_wall();
			}
		}
		
		module cell_inner_wall() {
			if(style == "upper") {
			    upper_wall();
				if(x_cell % 2 != 0) {
					up_right_wall();
				}
			} else if(style == "right") {
				right_walls();
			} else {
				if(x_cell % 2 == 0) {
				 	down_right_wall();
				}
				else {
					up_right_wall();
				}
			}
		}
		
		module cell_wall() {
			cell_inner_wall();
			cell_border_wall();
		}

		grid_h = 2 * cell_radius * sin(60);
		grid_w = cell_radius + cell_radius * cos(60);

		translate([grid_w * x_cell, grid_h * y_cell + (x_cell % 2 == 0 ? 0 : grid_h / 2), 0]) 
			cell_wall();
	}
	
	// create the wall of maze

	for(i = [0:len(maze_vector) - 1]) {
		cord = maze_vector[i];
		x = (cord[0] - 1) ;
		y = (cord[1] - 1);
		v = cord[2];

		if(v == 1 || v == 3) {
			cell(x, y, "upper");
		}
		if(v == 2 || v == 3) {
			cell(x, y, "right");
		}  
		
		cell(x, y); 
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
		    hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness);

	if(shadow == "YES") {
		color("black") 
		linear_extrude(wall_height) 
		    translate([grid_w - square_w / 2, grid_h - square_w / 2, 0]) 
			    hex_maze(y_cells, x_cells, maze_vector, cell_radius, wall_thickness);
    }
        
}

hex_maze_stereographic_projection(x_cells, cell_radius, wall_thickness, fn, wall_height, shadow);