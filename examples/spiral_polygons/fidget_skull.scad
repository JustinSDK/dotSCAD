use <rounded_square.scad>

beginning_radius = 5;
fn = 6;
number_of_polygons = 6;
height = 15;
thickness = 1;
spacing = 1;
slope = 0.65;
base_height = height * 1.75;

fidget_skull(beginning_radius, fn, number_of_polygons, height, thickness, spacing, slope, base_height);

module fidget_skull(beginning_radius, fn, number_of_polygons, height, thickness, spacing, slope, base_height) {
    
    skull_scale = .925;

    n = number_of_polygons + 1;
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

	module drawPolygon(r) {
        rotate(180)
		circle(r, $fn = fn);
	}
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
            //translate([0, 0, -half_height / 2])
			linear_extrude(half_height, scale = s[0])
			difference() {
				drawPolygon(beginning_radius);
				drawPolygon(beginning_radius - thickness);
			}
			//rotate(-(n) * 5)
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
              //  rotate(i * 5)
				difference() {
					drawPolygon(rs[i]);
					drawPolygon(rs[i] - thickness);
				}					
			}
		}
	}
	
    translate([rs[len(rs) - 1] * 1.1, 0]) 
    rotate(90) {
        half();	
        mirror([0, 0, 1])
            half();
    }
    translate([-rs[len(rs) - 1]  * 1.1, 0]) 
    rotate(90) {
        half();	
        mirror([0, 0, 1])
            half();
    }

    // scope
    module teeth() {
        translate([rs[len(rs) - 1] * .6, -rs[len(rs) - 1] * 1.2])
        rotate(5)
            rounded_square(size = [beginning_radius * 1.45, beginning_radius * 1.75], corner_r = beginning_radius / 5, center = true);

        translate([0, -rs[len(rs) - 1] * 1.2])
            rounded_square(size = [beginning_radius * 1.35, beginning_radius * 1.8], corner_r = beginning_radius / 5, center = true);

        translate([-rs[len(rs) - 1] * .65, -rs[len(rs) - 1] * 1.2])
        rotate(-5)
            rounded_square(size = [beginning_radius * 1.5, beginning_radius * 1.5], corner_r = beginning_radius / 5, center = true);
    }

    module skull_scope() {
        offset(thickness * 1.5) 
        hull() {
            translate([rs[len(rs) - 1] * 1.1, 0])
            scale(s[n - 1])
            rotate(90)
                drawPolygon(rs[n - 1]);

            translate([-rs[len(rs) - 1] * 1.1, 0])
            scale(s[n - 1])
            rotate(90)
                drawPolygon(rs[n - 1]);
        }
        
        offset(thickness * 6)
        hull()
            teeth();
    }

    module skull() {
        linear_extrude(height / 2, scale = skull_scale)
        difference() {
            translate([0, 0, -height / 2])
                skull_scope();
            teeth();

            // nose
            translate([beginning_radius / 4, -beginning_radius * 2])
            rotate(-15)
            scale([1, 2])
                circle(beginning_radius / 2.5);

            translate([-beginning_radius / 4, -beginning_radius * 2])
            rotate(15)
            scale([1, 2])
                circle(beginning_radius / 2.5);
        }        
    }

    module eye_socket() {
        translate([0, 0, -half_height])
        linear_extrude(half_height, scale = s[n - 1])
        rotate(90)
            drawPolygon(rs[n - 1]);
    }
    
    difference() {
        union() {
            skull();
            mirror([0, 0, 1])
                skull();
        }
        
        translate([rs[len(rs) - 1] * 1.1, 0]) {
            eye_socket();	
            mirror([0, 0, 1])
                eye_socket();
        }

        translate([-rs[len(rs) - 1] * 1.1, 0]) {
            eye_socket();	
            mirror([0, 0, 1])
                eye_socket();
        }
    }
}