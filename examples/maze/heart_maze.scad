use <line2d.scad>;
use <hollow_out.scad>;
use <ellipse_extrude.scad>;
use <arc.scad>;
use <experimental/mz_blocks.scad>;

radius_of_heart = 12;
height_of_heart = 25;
tip_r_of_heart = 5;
wall_thickness = 2;
cblocks = 6;
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

module heart_maze(maze, radius, cblocks, levels, thickness = 1) {    
    // NO_WALL = 0;       
	// UPPER_WALL = 1;    
	// RIGHT_WALL = 2;    
	// UPPER_RIGHT_WALL = 3; 

	function no_wall(block) = get_wall_type(block) == 0;
	function upper_wall(block) = get_wall_type(block) == 1;
	function right_wall(block) = get_wall_type(block) == 2;
	function upper_right_wall(block) = get_wall_type(block) == 3;

	function block(x, y, wall_type, visited) = [x, y, wall_type, visited];
	function get_x(block) = block[0];
	function get_y(block) = block[1];
	function get_wall_type(block) = block[2];
	
    arc_angle = 360 / cblocks;
	r = radius / (levels + 1);

	difference() {
		render() union() {
			for(i = [1 : levels + 1]) {
			    ring_heart(r * i, thickness);
			}
		  
		  
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block); 
				cc = get_y(block) - 1;    
				
				angle = cc * arc_angle;
				 
				if(upper_wall(block) || upper_right_wall(block)) { 
				    heart_to_heart_wall(r * cr, r, cc * arc_angle , thickness);
				} 
			}
	    }
		
		render() union() {
	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block); 
				cc = get_y(block) - 1;   
				
				if(no_wall(block) || upper_wall(block)) { 
				    ring_heart_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, thickness * 0.75);
				}  
			}
		}
	}
}

maze = mz_blocks(
	[1, 1],  
	cblocks, levels, y_circular = true
);

intersection() {
	union() {
		ellipse_extrude(height_of_heart / 2) 
			heart(radius_of_heart + wall_thickness , tip_r_of_heart);		

		mirror([0, 0, 1]) 
		ellipse_extrude(height_of_heart / 2) 
			heart(radius_of_heart + wall_thickness, tip_r_of_heart); 
	}

	linear_extrude(height_of_heart, center = true) 
	    heart_maze(maze, radius_of_heart, cblocks, levels, wall_thickness); 	
}

linear_extrude(wall_thickness * 2, center = true) 
translate([0, radius_of_heart * 1.25])
   arc(radius = radius_of_heart / 3, angle = [25, 155], width = wall_thickness);