use <hollow_out.scad>

$fn = 48;

radius = 40;
thickness = 2;
layers = 5;
spacing = 2.5;
drill_angle = 36;
support_thickness = 1;

fidget_ball(radius, thickness, layers, spacing, drill_angle, support_thickness);

module fidget_ball(radius, thickness, layers, spacing, drill_angle, support_thickness) {
	module drill(deep, drill_angle) {
		a = drill_angle / 2;
		r = deep * tan(a);
		
		difference() {
			children(0);
			union() {
				for(i = [0:3]) {
					rotate([90 * i, 0, 0])
					translate([0, 0, -deep])
					linear_extrude(deep, scale = 0.01)
						circle(r);
				}
				for(i = [90, -90]) {
					rotate([0, i, 0])
					translate([0, 0, -deep])
					linear_extrude(deep, scale = 0.01)
						circle(r);
				}

				for(i = [0:3]) {
					rotate([0, 54.7356, 45 + i * 90])
					translate([0, 0, -deep])
					linear_extrude(deep, scale = 0.01)
						circle(r);

					rotate([0, -125.2644, 45 + i * 90])
					translate([0, 0, -deep])
					linear_extrude(deep, scale = 0.01)
						circle(r);
				}
			}	
		}
	}

	module hollow_sphere(radius, thickness) {
		difference() {
			sphere(radius);
			sphere(radius - thickness);
		}
	}

	module support(i, sphere_r, height, support_thickness, drill_angle) {
		a = drill_angle / 2;
		support_r = 2 * sphere_r * sin(a / 2) ^ 2;

		sina = sin(a);
		tana = tan(a);

		translate([0, 0, -sphere_r])
		rotate_extrude()
		translate([sphere_r * sina, 0])
			polygon([[0, support_r], [-.75, support_r], [-tana * support_r - support_thickness, 0], [-tana * support_r, 0]]);

		translate([0, 0, -sphere_r - height * i])
		linear_extrude(height * i)
		hollow_out(support_thickness)
		    circle(sphere_r * sina - tana * support_r);

	}

	r_step = thickness + spacing;
	
	drill(radius, drill_angle)
	for(i = [0:layers - 1]) {
		hollow_sphere(radius - r_step * i, thickness);
	}
	
	for(i = [0:layers - 1]) {
		support(i, radius - r_step * i, r_step, support_thickness, drill_angle);
	}
}