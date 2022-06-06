use <line2d.scad>
use <hollow_out.scad>
use <ellipse_extrude.scad>
use <arc.scad>
use <maze/mz_square.scad>
use <maze/mz_square_get.scad>

radius_of_heart = 12;
height_of_heart = 25;
tip_r_of_heart = 5;
wall_thickness = 2;
ccells = 6;
levels = 3;

$fn = 36;

module heart(radius, tip_r) {
    offset_h = 0.410927 * radius;
	
    translate([radius * 0.707107, offset_h, 0]) 
    rotate([0, 0, -45])
    hull() {
        circle(radius);
		translate([radius - tip_r, -radius * 2 + tip_r, 0]) 
		    circle(tip_r);
	}
	
	translate([-radius * 0.707107, offset_h, 0]) 
    rotate([0, 0, 45]) 
    hull() {
        circle(radius);
		translate([-radius + tip_r, -radius * 2 + tip_r, 0]) 
		    circle(tip_r);
	}
}
    
module ring_heart(radius, thickness) {
    hollow_out(thickness) 
        heart(radius + thickness / 2, 5);
}

module ring_heart_sector(radius, angle, thickness, width) {
	intersection() {
		ring_heart(radius, thickness + 0.2);
		rotate([0, 0, angle]) 
            line2d([0, 0], [0, radius * 3 + width + thickness], width);
	}
}

module heart_to_heart_wall(radius, length, angle, thickness) {
    intersection() {
        difference() {
            heart(radius + thickness / 2 + length , 5);
            heart(radius + thickness / 2, 5);
	    }
	    rotate([0, 0, angle]) 
            line2d([0, 0], [0, (radius + length) * 2 + thickness], thickness);
	}
}

module heart_maze(cells, radius, ccells, levels, thickness = 1) {    
	function no_wall(cell) = get_type(cell) == "NO_WALL";
	function top_wall(cell) = get_type(cell) == "TOP_WALL";
	function right_wall(cell) = get_type(cell) == "RIGHT_WALL";
	function top_right_wall(cell) = get_type(cell) == "TOP_RIGHT_WALL";

	function get_x(cell) = mz_square_get(cell, "x"); 
	function get_y(cell) = mz_square_get(cell, "y");
	function get_type(cell) = mz_square_get(cell, "t");
	
    arc_angle = 360 / ccells;
	r = radius / (levels + 1);

	difference() {
		render() union() {
			for(i = [1 : levels + 1]) {
			    ring_heart(r * i, thickness);
			}
		  
		  
			for(row = cells, cell = row) { 
				cr = get_x(cell) + 1; 
				cc = get_y(cell);    
				
				angle = cc * arc_angle;
				 
				if(top_wall(cell) || top_right_wall(cell)) { 
				    heart_to_heart_wall(r * cr, r, cc * arc_angle , thickness);
				} 
			}
	    }
		
		render() union() {
	        // road to the next level
			for(row = cells, cell = row) { 
				cr = get_x(cell) + 1; 
				cc = get_y(cell);   
				
				if(no_wall(cell) || top_wall(cell)) { 
				    ring_heart_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, thickness * 0.75);
				}  
			}
		}
	}
}

cells = mz_square(ccells, levels, y_wrapping = true);

intersection() {
	union() {
		ellipse_extrude(height_of_heart / 2) 
			heart(radius_of_heart + wall_thickness , tip_r_of_heart);		

		mirror([0, 0, 1]) 
		ellipse_extrude(height_of_heart / 2) 
			heart(radius_of_heart + wall_thickness, tip_r_of_heart); 
	}

	linear_extrude(height_of_heart, center = true) 
	    heart_maze(cells, radius_of_heart, ccells, levels, wall_thickness); 	
}

linear_extrude(wall_thickness * 2, center = true) 
translate([0, radius_of_heart * 1.25])
   arc(radius = radius_of_heart / 3, angle = [25, 155], width = wall_thickness);