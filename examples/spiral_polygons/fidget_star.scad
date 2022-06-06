use <shape_star.scad>

model = "STAR"; // [STAR, BASE, BOTH]
r1 = 12;
r2 = 9.5;
n = 6;
number_of_stars = 8;
height = 20;
thickness = 1;
spacing = thickness;
slope = 0.35;
base_height = height * 1.75;

/*
r1 = 12;
r2 = 10;
n = 8;
number_of_stars = 10;
height = 20;
thickness = 1;
spacing = thickness;
slope = 0.26;
*/

fidget_star(model, r1, r2, n, number_of_stars, height, thickness, spacing, slope, base_height);
	
module fidget_star(model, r1, r2, n, number_of_stars, height, thickness, spacing, slope, base_height) {
    theta = 180 / n;

	y = r2 - r2 * cos(theta);
	dr = y / cos(theta) + thickness + spacing;
	
	r_ratio = r1 / r2;

	module star(r1, r2) {
	    polygon(shape_star(r1, r2, n));
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
	

	if(model == "STAR" || model == "BOTH") {
		half();	
		mirror([0, 0, 1])
			half();
	}
	// base

	ring_thickness = thickness * 1.5;
    module base_ring() {
		translate([0, 0, -ring_thickness])
		difference() {
			linear_extrude(ring_thickness, scale = 1.02)
			offset(ring_thickness / 3, $fn = n)
			offset(delta = -thickness)
				star(rs2[number_of_stars] * s[number_of_stars] * r_ratio, rs2[number_of_stars] * s[number_of_stars]);

			linear_extrude(thickness * 4, center = true)
			offset(delta = -ring_thickness)
				star(rs2[number_of_stars] * s[number_of_stars] * r_ratio, rs2[number_of_stars] * s[number_of_stars]);
		}
	}

    if(model == "BASE" || model == "BOTH") {
		color("white") {
			// plate
			translate([0, 0, -half_height])
			linear_extrude(half_height, scale = s[number_of_stars])
			difference() {
				star(rs1[number_of_stars], rs2[number_of_stars]);
				offset(delta = -thickness)
					star(rs1[number_of_stars], rs2[number_of_stars]);
			}			

			// ring
			base_ring();
			mirror([0, 0, 1])
				base_ring();

			*translate([0, 0, -base_height + ring_thickness])
			mirror([0, 0, 1])
			scale([1, 1, 1.5])
				base_ring();

			// stick
			d = rs1[number_of_stars] * s[number_of_stars];
			off_h = -base_height + ring_thickness;
			a = 180 / n;
			stick_r = thickness * 5;
			stick_h = base_height - ring_thickness;
			for(i = [0:n - 1]) {
				rotate(360 / n * i)
				translate([d + thickness * 1.25, 0, off_h]) 
				rotate(a) {
					linear_extrude(stick_h)
						circle(stick_r, $fn = n);
					translate([0, 0, stick_h])
					linear_extrude(ring_thickness, scale = 0.75)
						circle(stick_r, $fn = n);
				}
			}
		}
	}
}