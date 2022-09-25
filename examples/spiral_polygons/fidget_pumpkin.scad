beginning_radius = 7.5;

number_of_polygons = 6;
height = 15;
thickness = 1;
spacing = 1.35;
slope = 0.58;
central_scale = 1;

$fn = 12;
        
fidget_pumpkin(beginning_radius, number_of_polygons, height, thickness, spacing, slope, central_scale);

module fidget_pumpkin(beginning_radius, n, height, thickness, spacing, slope, central_scale) {
    fn = 8;
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

    module pumpkin(r) {
        scale(0.7 * r) 
        translate([0, .125]) {
            scale([1, 1.15]) {
                scale([1.2, 1.325])
                    circle(1);

                scale([1.2, 1.3])
                translate([-.5, 0])
                    circle(1);

                scale([1.2, 1.3])
                translate([.5, 0])
                    circle(1);
            }

            hull() {
                translate([.1, 1.4])
                circle(.25);

                translate([.15, 1.5])
                circle(.15);
            }
        }
    }
    
	module eye() {
        scale([1.2, 1] * 1.25)
        difference() {
             circle(1.5);
             translate([0, 2])
                 square(3, center = true);
        }
	}
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
		    //translate([0, 0, -4.5])
			difference() {
				linear_extrude(half_height, scale = s[0])
				scale(central_scale)
					pumpkin(beginning_radius);
					
                
                linear_extrude(thickness * 2, center = true) {
                    translate([beginning_radius * 0.5, beginning_radius * 0.45]) 
                    rotate(25)
                        eye();
                    
                    translate([-beginning_radius * 0.5, beginning_radius * 0.45]) 
                    rotate(-25)
                        eye();
                }
                
                linear_extrude(thickness * 2, center = true)
                difference() {
                    translate([0, -1.25])
                    scale([1.6, 1])
                    difference() {
                        circle(4);
                        translate([0, 4.75])
                            square(8, center = true);
                    }
                    translate([-beginning_radius * 0.45, 0])
                    rotate(-85)
                        circle(2.5, $fn = 3);
                        
                    translate([beginning_radius * 0.45, 0])
                    rotate(-95)
                        circle(2.5, $fn = 3);

                        
                    translate([0, beginning_radius * -0.7])
                    rotate(-30)
                        circle(2.5, $fn = 3);
                }
			}
			
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					pumpkin(rs[i]);
				    pumpkin(rs[i] - thickness);
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
		half();
}