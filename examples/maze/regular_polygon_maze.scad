use <line2d.scad>;
use <hollow_out.scad>;
use <maze/mz_square_blocks.scad>;
use <maze/mz_square_get.scad>;

// only for creating a small maze

radius_of_circle_wrapper = 15;
wall_thickness = 1;
wall_height = 1;
cblocks = 6;
levels = 3;
sides = 3; 
    
module ring_regular_polygon(radius, thickness, sides) {
    hollow_out(thickness) 
        circle(radius + thickness / 2, $fn = sides);
}

module ring_regular_polygon_sector(radius, angle, thickness, width, sides) {
	intersection() {
		ring_regular_polygon(radius, thickness + 0.2, sides);
		rotate([0, 0, angle]) 
            line2d([0, 0], [0, radius * 3 + width], width);
	}
}

module regular_polygon_to_polygon_wall(radius, length, angle, thickness, sides) {
   intersection() {
        difference() {
		    circle(radius + length, $fn = sides);
			circle(radius, $fn = sides);
	    }
	    rotate([0, 0, angle]) 
            line2d([0, 0], [0, (radius + length) * 2 + thickness], thickness);
	}
}

module regular_polygon_maze(radius, cblocks, levels, thickness = 1, sides) {    
	function no_wall(block) = get_wall_type(block) == "NO_WALL";
	function top_wall(block) = get_wall_type(block) == "TOP_WALL";
	function right_wall(block) = get_wall_type(block) == "RIGHT_WALL";
	function top_right_wall(block) = get_wall_type(block) == "TOP_RIGHT_WALL";

	function get_x(block) = mz_square_get(block, "x"); 
	function get_y(block) = mz_square_get(block, "y");
	function get_wall_type(block) = mz_square_get(block, "w");

    arc_angle = 360 / cblocks;
	r = radius / (levels + 1);
	
	maze = mz_square_blocks(
		cblocks, levels, y_wrapping = true
	);

	difference() {
		render() union() {
			for(i = [1 : levels + 1]) {
			    ring_regular_polygon(r * i, thickness, sides);
			}
		  
		  
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block) + 1; 
				cc = get_y(block);    
				
				angle = cc * arc_angle;
				 
				if(top_wall(block) || top_right_wall(block)) { 
				    regular_polygon_to_polygon_wall(r * cr, r, cc * arc_angle , thickness, sides);
				} 
			}
	    }
		
		render() union() {
		    // maze entry
			// ring_regular_polygon_sector(r, arc_angle / 1.975 , thickness, r / 3, sides);   

	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block) + 1; 
				cc = get_y(block);   
				
				if(no_wall(block) || top_wall(block)) { 
				    ring_regular_polygon_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, thickness * 0.75 , sides);
				}  
			}
		}
	}
}

linear_extrude(wall_height) 
    regular_polygon_maze(radius_of_circle_wrapper, cblocks, levels, wall_thickness, sides); 			
