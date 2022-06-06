use <regular_polygon_maze.scad>
use <hollow_out.scad>

ccells = 8; 
wall_thickness = 1.5;
spacing = 0.6;
$fn = 48;

gyro_maze(ccells, wall_thickness, spacing);

module gyro_maze(ccells, wall_thickness, spacing) {
    // Don't change these variables. They require more math.
    radius = 15;
    wall_height = 1;
    levels = 4;
    h = radius / 3;

    module maze() {
        translate([0, 0, radius / 3 - wall_height])
        linear_extrude(wall_height) 
        scale(1.029) {
            difference() {
                regular_polygon_maze(radius - wall_thickness, ccells, levels - 1, wall_thickness, $fn); 
                circle(radius / 3.5);
            }
            circle(radius / 3.5 - wall_thickness / 1.45);
        }
    }

    intersection() {
        gyro(radius, levels, spacing);
        union() {
            maze();
            mirror([0, 0, 1]) maze();
        }
    }

    difference() {
        gyro(radius, levels, spacing);
        
        translate([0, 0, h - wall_height])
        linear_extrude(wall_height) 
            square(radius * 2, center = true);

        translate([0, 0, -h])
        linear_extrude(wall_height) 
            square(radius * 2, center = true);        
    }
}

module gyro(radius, layers, spacing) {
	h = radius / 3;
    half_r = radius / 2.75;
    r_step = (radius - half_r) / (layers - 1);
    
    module rings() {
        ring_thickness = r_step - spacing;
        circle(half_r);
        for(i = [1:layers - 1]) {
            hollow_out(ring_thickness) 
                circle(half_r + r_step * i);        
        }
    }

    rotate_extrude()
    intersection() {
        translate([0, -h]) 
            square([radius, h * 2]);
        rings();
    }
}