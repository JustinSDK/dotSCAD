use <polyline_join.scad>
use <hollow_out.scad>
use <util/dedup.scad>
use <turtle/lsystem2.scad>
use <experimental/ptf_c2sphere.scad>

$fn = 48;

radius = 36;
thickness = 2;
spacing = 3;
drill_angle = 38;
support_thickness = 1;

engraved = false; // [true, false], warning: previewing is very slow when it's true.

fidget_ball_fern_leaf(radius, thickness, spacing, drill_angle, support_thickness);

module fidget_ball_fern_leaf(radius, thickness, spacing, drill_angle, support_thickness) {
	module fern_ball(radius, thickness, fern_n, thickness_scale) {
		function fern(n = 8, angle = 4, leng = 1, heading = 0, start = [0, 0]) = 
			let(
				axiom = "EEEA",
				rules = [
					["A", "[++++++++++++++EC]B+B[--------------ED]B+BA"],
					["C", "[---------EE][+++++++++EE]B+C"],
					["D", "[---------EE][+++++++++EE]B-D"]
				]
			)
			lsystem2(axiom, rules, n, angle, leng, heading, start, forward_chars = "ABCDE");  
			
		r = radius * sin(drill_angle / 2) / 2;
		fern = [
			for(line = dedup(fern(n = fern_n)))
			[
				ptf_c2sphere(line[0] + [r, 0], radius * 0.99),
				ptf_c2sphere(line[1] + [r, 0], radius * 0.99)
			]
		];

		module ferns(n) {
			a_step = 360 / n;
			for(i = [0:n - 1]) {
				rotate(i * a_step)
				for(line = fern) {
				    polyline_join(line)
					    sphere(thickness * thickness_scale / 2, $fn = 5);
				}
			}
		}

		module fern_ball() {
			ferns(4);
			
			mirror([1, 0, 0])
			mirror([0, 0, 1])
				ferns(4);
				
			mirror([0, 1, 1])
				ferns(2);

			mirror([0, 1, 0])
			mirror([0, 1, 1])
				ferns(2);
		}		

        if(engraved) {
			difference() {
				render() 
				difference() {
					sphere(radius);
					sphere(radius - thickness);
				}
				
				fern_ball();
			}
		}
        else {
			color("black") 
			difference() {
				sphere(radius);
				sphere(radius - thickness);
			}
			
			fern_ball();
		}
	}

	r_step = thickness + spacing;
	radiuses = [radius, radius - r_step, radius - r_step * 2];

	fidget_ball_drill_support(radius, thickness, spacing, support_thickness) {
	   fern_ball(radiuses[0], thickness, fern_n = 5, thickness_scale = 0.75);
	   mirror([0, 1, 1]) fern_ball(radiuses[1], thickness, fern_n = 4, thickness_scale = 0.65);
	   mirror([1, 1, 0]) fern_ball(radiuses[2], thickness, fern_n = 3, thickness_scale = 0.55);
	};
}

module fidget_ball_drill_support(radius, thickness, spacing, support_thickness) {
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
	for(i = [0:$children - 1]) {
	    children(i);
	}

	for(i = [0:$children - 1]) {
		support(i, radius - r_step * i, r_step, support_thickness, drill_angle);
	}
}
