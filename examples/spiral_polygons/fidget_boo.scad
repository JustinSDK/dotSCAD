use <experimental/r_union2.scad>

beginning_radius = 7.5;

number_of_polygons = 6;
height = 15;
thickness = 1;
spacing = 1.4;
slope = 0.58;
central_scale = 1;

$fn = 48;

fidget_boo(beginning_radius, number_of_polygons, height, thickness, spacing, slope, central_scale);

module fidget_boo(beginning_radius, n, height, thickness, spacing, slope, central_scale) {
    fn = 8;
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

    module boo(r) {
        scale(r)
        translate([0, .1]) {
            union() {
                r_union2(radius = .06) {
                    hull() {
                        circle(1);
                        
                        translate([.25, -.5])
                        rotate(15)
                        scale([1.5, 1])
                            circle(.5);
                    }
                    translate([.9, -.57])
                    rotate(-30)
                        circle(0.25, $fn = 3);
                }
                
                r_union2(radius = .06) {
                    translate([1, .2])
                        circle(1 / 6);
                    circle(1);
                }
                
                r_union2(radius = .06) {
                    translate([-1, 0])
                        circle(1 / 6);
                    circle(1);
                }
            }
            translate([0.35, .5])
                circle(1 / 8);
            
            translate([-0.35, .5])
                circle(1 / 8);
            
            translate([0, .6])
            scale([1, 2.5])
            difference() {
                circle(.25);
                translate([0, .1])
                    square(.5, center = true);
            }
        }
    }
    
	module face(r) {
        scale(r) {
            translate([0.35, .5])
                circle(1 / 8);
            
            translate([-0.35, .5])
                circle(1 / 8);
            
            translate([0, .6])
            scale([1, 2.5])
            difference() {
                circle(.25);
                translate([0, .1])
                    square(.5, center = true);
            }
        }
	}
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
		    // translate([0, 0, -4.6])
			difference() 
            {
				linear_extrude(half_height, scale = s[0])
				scale(central_scale)
					boo(beginning_radius);
			    
                linear_extrude(thickness * 2, center = true) 
                scale(central_scale)
                    face(beginning_radius);
			}
			
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					boo(rs[i]);
                    offset(-thickness)
				        boo(rs[i] );
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
		half();
}