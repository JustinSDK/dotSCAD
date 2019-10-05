include <line2d.scad>;
include <hollow_out.scad>;
include <square_maze.scad>;
include <ellipse_extrude.scad>;

// only for creating a small maze

radius_of_heart = 15;
wall_thickness = 2;
wall_height = 1;
cblocks = 6;
levels = 3;
semi_minor_axis = 15;

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
        heart(radius + thickness, 5);
}

module ring_heart_sector(radius, angle, thickness, width) {
	intersection() {
		ring_heart(radius - 0.1, thickness + 0.2);
		rotate([0, 0, angle]) 
            line2d([0, 0], [0, radius * 3 + width], width);
	}
}

module heart_to_heart_wall(radius, length, angle, thickness) {
    intersection() {
        difference() {
            heart(radius + 1 + length , 5);
            heart(radius + 1, 5);
	    }
	    rotate([0, 0, angle]) 
            line2d([0, 0], [0, (radius + length) * 2 + thickness], thickness);
	}
}

module heart_maze(maze, radius, cblocks, levels, thickness = 1) {    
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
		    // maze entry
			// ring_heart_sector(r, arc_angle / 1.975 , thickness, r / 3);   

	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				block = maze[i];
				cr = get_x(block); 
				cc = get_y(block) - 1;   
				
				if(no_wall(block) || upper_wall(block)) { 
				    ring_heart_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, r / 3);
				}  
			}
		}
	}
}

maze = go_maze(1, 1, 
	starting_maze(cblocks, levels),
	cblocks, levels, y_circular = true
);

ellipse_extrude(semi_minor_axis, 10) 
    heart_maze(maze, radius_of_heart, cblocks, levels, wall_thickness); 			

mirror([0, 0, 1]) 
ellipse_extrude(semi_minor_axis, semi_minor_axis / 3 * 2) 
    heart_maze(maze, radius_of_heart, cblocks, levels, wall_thickness); 