use <shape_ellipse.scad>
use <shape_cyclicpolygon.scad>

beginning_radius = 7.5;

number_of_polygons = 6;
height = 20;
thickness = 1.25;
spacing = thickness * 1.75;
slope = 0.56;
central_scale = 1;

$fn = 48;

fidget_cat(beginning_radius, number_of_polygons, height, thickness, spacing, slope, central_scale);

module fidget_cat(beginning_radius, n, height, thickness, spacing, slope, central_scale) {
    fn = 8;
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

	module cat(r) {
		polygon(shape_ellipse([r, r * 0.95]));	
		
		rotate(45)
		translate([r * 0.9, 0])
		polygon(
            shape_cyclicpolygon(
                sides = 3, 
                circle_r = r * 0.5, 
                corner_r = r * 0.1
            )
        );
		
		rotate(135)
		translate([r * 0.9, 0])
		polygon(
            shape_cyclicpolygon(
                sides = 3, 
                circle_r = r * 0.5, 
                corner_r = r * 0.1
            )
        );
	}
	
	module eye() {
		difference() {
			circle(beginning_radius * 0.2);
			translate([beginning_radius * 0.05, 0])
			    circle(beginning_radius * 0.075);
		}
	}
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
		    // translate([0, 0, -7.3])
			difference() {
				linear_extrude(half_height, scale = s[0])
				scale(central_scale)
					cat(beginning_radius);
					
				linear_extrude(thickness * 2, center = true) {
					translate([beginning_radius * 0.4, beginning_radius * 0.15]) 
						eye();
					
					translate([-beginning_radius * 0.4, beginning_radius * 0.15]) 
						eye();
						
					translate([0, -beginning_radius * 0.2])
					rotate(-90)
					polygon(
						shape_cyclicpolygon(
							sides = 3, 
							circle_r = beginning_radius * 0.175, 
							corner_r = beginning_radius * 0.06
						)
					);
				}
			}
			
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					cat(rs[i]);
				    cat(rs[i] - thickness);
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
		half();
		
    
}