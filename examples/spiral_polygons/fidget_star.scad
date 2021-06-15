use <shape_starburst.scad>;

r1 = 12;
r2 = 8;
n = 6;
number_of_stars = 10;
height = 20;
thickness = 1.5;
spacing = 0.5 * thickness;
slope = 0.375;

/*
r1 = 12;
r2 = 9.55;
n = 8;
number_of_stars = 10;
height = 20;
thickness = 1.5;
spacing = 0.5 * thickness;
slope = 0.25;
*/

fidget_star(r1, r2, n, number_of_stars, height, thickness, spacing, slope);
	
module fidget_star(r1, r2, n, number_of_stars, height, thickness, spacing, slope) {
    theta = 180 / n;

	y = r2 - r2 * cos(theta);
	dr = y / cos(theta) + thickness + spacing;
	pw = pow((r2 + dr) * sin(theta), 2);
	
	r_ratio = r1 / r2;

	module star(r1, r2) {
	    polygon(shape_starburst(r1, r2, n));
	}
	
	rs2 = [for(i = [0: number_of_stars + 1]) r2 + i * dr];
	rs1 = rs2 * r_ratio;
	
	half_height = height / 2;

	s = [for(i = [1: number_of_stars + 1]) (rs2[i] + slope * half_height) / rs2[i]];

	module half() {
	    translate([0, 0, -half_height]) {
			linear_extrude(half_height, scale = s[0])
			difference() {
				star(r1, r2);
				offset(delta = -thickness)
				    star(r1, r2);
			}
				
			for(i = [1:number_of_stars - 1]) {
				linear_extrude(half_height, scale = s[i])
				difference() {
					star(rs1[i], rs2[i]);
					offset(delta = -thickness)
					    star(rs1[i], rs2[i]);
				}					
			}
		}
	}
	
	half();	
	mirror([0, 0, 1])
		half();
}