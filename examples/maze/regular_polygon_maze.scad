use <line2d.scad>
use <hollow_out.scad>
use <maze/mz_square.scad>
use <maze/mz_square_get.scad>

// only for creating a small maze

radius_of_circle_wrapper = 15;
wall_thickness = 1;
wall_height = 1;
ccells = 6;
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

module regular_polygon_maze(radius, ccells, levels, thickness = 1, sides) {    
	function no_wall(cell) = get_type(cell) == "NO_WALL";
	function top_wall(cell) = get_type(cell) == "TOP_WALL";
	function right_wall(cell) = get_type(cell) == "RIGHT_WALL";
	function top_right_wall(cell) = get_type(cell) == "TOP_RIGHT_WALL";

	function get_x(cell) = mz_square_get(cell, "x"); 
	function get_y(cell) = mz_square_get(cell, "y");
	function get_type(cell) = mz_square_get(cell, "t");

    arc_angle = 360 / ccells;
	r = radius / (levels + 1);
	
	cells = mz_square(ccells, levels, y_wrapping = true);

	difference() {
		union() {
			for(i = [1 : levels + 1]) {
			    ring_regular_polygon(r * i, thickness, sides);
			}
		  
		  
			for(row = cells, cell = row) { 
				cr = get_x(cell) + 1; 
				cc = get_y(cell);    
				
				angle = cc * arc_angle;
				 
				if(top_wall(cell) || top_right_wall(cell)) { 
				    regular_polygon_to_polygon_wall(r * cr, r, cc * arc_angle , thickness, sides);
				} 
			}
	    }
		
		union() {
		    // maze entry
			// ring_regular_polygon_sector(r, arc_angle / 1.975 , thickness, r / 3, sides);   

	        // road to the next level
			for(row = cells, cell = row) { 
				cr = get_x(cell) + 1; 
				cc = get_y(cell);   
				
				if(no_wall(cell) || top_wall(cell)) { 
				    ring_regular_polygon_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, thickness * 0.75 , sides);
				}  
			}
		}
	}
}

linear_extrude(wall_height) 
    regular_polygon_maze(radius_of_circle_wrapper, ccells, levels, wall_thickness, sides); 			
