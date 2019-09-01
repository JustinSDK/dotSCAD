include <line2d.scad>;
include <arc.scad>;
include <hollow_out.scad>;
include <maze.scad>;

radius_of_circle_wrapper = 15;
wall_thickness = 1;
wall_height = 1;
cblocks = 12;
levels = 3;
sides = 6; // [3:24]
bottom = "NO"; // [YES,NO]

module regular_polygon_maze(radius, cblocks, levels, thickness = 1, sides) {
    full_circle_angle = 360;
    arc_angle = full_circle_angle / cblocks;
	r = radius / (levels + 1);
	
	maze = go_maze(1, 1, cblocks, levels, replace([levels, cblocks - 1, 0, UP_RIGHT_WALL()], [levels, cblocks - 1, 0, UP_WALL()], init_maze(cblocks, levels)));

    // give a [x, y] point and length. draw a line in the x direction
    module x_line(point, length, thickness = 1) {
        line2d(point, point + [0, length], width = thickness);
    }

    module ring_regular_polygon_sector(radius, angle, thickness, width, sides) {
        intersection() {
            arc(
                radius = radius - 0.1, 
                angle = [0, 360], 
                width = thickness + 0.2, 
                width_mode = "LINE_OUTWARD",
                $fn = sides
            );

            rotate([0, 0, angle]) x_line([0, 0], radius * 3, width);
        }
    }

    module regular_polygon_to_polygon_wall(radius, length, angle, thickness, sides) {
        intersection() {
            hollow_out(shell_thickness = length) 
                circle(r = radius + length, $fn = sides);
            rotate([0, 0, angle]) 
                x_line([0, 0], (radius + length) * 2, thickness);
        }
    }
	
	difference() {
		 union() {
			for(i = [1 : levels + 1]) {
                arc(
                    radius = r * i, 
                    angle = [0, 360], 
                    width = thickness, 
                    width_mode = "LINE_OUTWARD",
                    $fn = sides
                );
			}
		  
			for(i = [0:len(maze) - 1]) { 
				cord = maze[i];
				cr = cord[0]; 
				cc = cord[1] - 1;    
				v = cord[3];
				
				angle = cc * arc_angle;
				 
				if(v == 1 || v == 3) { 
				    regular_polygon_to_polygon_wall(r * cr, r, cc * arc_angle , thickness, sides);
				} 
			}
	    }
		
		 union() {
		    // maze entry
			ring_regular_polygon_sector(r, arc_angle / 1.975 , thickness, r / 3, sides);   

	        // road to the next level
			for(i = [0:len(maze) - 1]) { 
				cord = maze[i];
				cr = cord[0]; 
				cc = cord[1] - 1;    
				v = cord[3];
				
				if(v == 0 || v == 1) { 
				    ring_regular_polygon_sector(r * (cr + 1), (cc + 0.5) * arc_angle , thickness, r / 3 , sides);
				}  
			}
		}
	}
}

linear_extrude(wall_height) 
    regular_polygon_maze(radius_of_circle_wrapper, cblocks, levels, wall_thickness, sides); 			

if(bottom == "YES") {
    linear_extrude(wall_height / 2)
        offset(delta = wall_thickness) 
	        circle(radius_of_circle_wrapper, $fn = sides);
}