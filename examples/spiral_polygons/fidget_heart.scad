beginning_radius = 7.5;

number_of_polygons = 9;
height = 20;
thickness = 1.25;
spacing = thickness * 1.75;
slope = 0.575;

$fn = 24;

fidget_heart(beginning_radius, number_of_polygons, height, thickness, spacing, slope);

module fidget_heart(beginning_radius, n, height, thickness, spacing, slope) {
    fn = 8;
    theta = 180 / fn;

	y = beginning_radius - beginning_radius * cos(theta);
	dr = y / cos(theta) + thickness + spacing;

	module heart(r) {
		module _heart(r1, r2) {
			half_r = r1 / 2;
			
			hull() {
				translate([half_r * cos(30), half_r * sin(45)])
					circle(half_r);
				translate([0, -r1 + 18 * r2]) 
					circle(r2);
			}
				
			hull() {
				translate([-half_r * cos(30), half_r * sin(45)])
					circle(half_r);
					
				translate([0, -r1 + 18 * r2]) 
					circle(r2);
			}
		}
	
		offset(r * 0.2)
		    _heart(r, r * 0.01);
	}
	
	
	rs = [for(i = [0: n + 1]) beginning_radius + i * dr];
	
	half_height = height / 2;

	s = [for(i = [1: n + 1]) (rs[i] + slope * half_height) / rs[i]];

	module half() {
	    translate([0, 0, -half_height]) {
		    //translate([0, 0, -7])
			linear_extrude(half_height, scale = s[0])
			difference() {
				heart(beginning_radius);
				offset(-thickness)
				    heart(beginning_radius);
			}
				
			for(i = [1:n - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					heart(rs[i]);
					offset(-thickness)
					    heart(rs[i]);
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
		half();
}