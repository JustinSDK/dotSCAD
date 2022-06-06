use <shear.scad>

text = "順暢";
font = "思源黑體 Heavy";
font_size = 15;
nose = true;
smoothing = false; // warning: previewing is slow if it's true.

scale(smoothing ? 0.985 : 1)
    daruma(nose);

wish_decoration(text, font, font_size);

module daruma(nose) {
    radius = 10;

	module body() {
		translate([0, 0, radius * 2.75])
		shear(sy = [.025, 0])
		minkowski() {
			linear_extrude(radius * 2, scale = 0.4)
			translate([0, -radius / 4])
				circle(radius);
				
			sphere(radius * 4, $fn = 48);
		}
	}

	module mask_face() {
		module bend_extrude(size, thickness, angle, frags = 24) {
			x = size[0];
			y = size[1];
			frag_width = x / frags ;
			frag_angle = angle / frags;
			half_frag_width = 0.5 * frag_width;
			half_frag_angle = 0.5 * frag_angle;
			r = half_frag_width / sin(half_frag_angle);
			s =  (r - thickness) / r;
			
			module get_frag(i) {
				offsetX = i * frag_width;
				translate([0, y / 2, 0]) 
				linear_extrude(thickness, scale = s) 
					translate([-offsetX - half_frag_width, -y / 2, 0]) 
					intersection() {
						translate([x, 0, 0]) 
						mirror([1, 0, 0]) 
							children();
						translate([offsetX, 0, 0]) 
							square([frag_width, y]);
					}
			}

			offsetY = -r * cos(half_frag_angle) ;

			rotate(angle - 90)
			mirror([0, 1, 0])
			mirror([0, 0, 1])
				for(i = [0 : frags - 1]) {
				    rotate(i * frag_angle + half_frag_angle) 
					translate([0, offsetY, 0])
					rotate([-90, 0, 0]) 
						get_frag(i) 
							children();  
				}
		}
		
		translate([0, -radius, radius * 1.4])
		scale([1.27, 1, 1])
		rotate([-24, 0, 0])
		rotate(225)
		bend_extrude(size = [radius * 16, radius * 8], thickness = radius, angle = 180, frags = 36)
		translate([radius * 4, radius * 2.5])
		hull() {
			$fn = 12;
			translate([0, radius * 1.75])
				circle(radius * 1.2);
				
			translate([radius * 1.45, radius * 1.5])
				circle(radius * 1.25, $fn = 24);

			translate([-radius * 1.45, radius * 1.5])
				circle(radius * 1.25, $fn = 24);
				
			translate([radius * 1.85, radius * 0.25])
			rotate(25)
			scale([1, 1.3])
				circle(radius * 1.3);
				
			translate([-radius * 1.85, radius * 0.25])
			rotate(-25)
			scale([1, 1.3])
				circle(radius * 1.3);
				
			translate([radius * 2.75, -radius * 1.2])
				circle(radius / 2);

			translate([-radius * 2.75, -radius * 1.2])
				circle(radius / 2);
		}	
	}

	module eyes_nose() {
		module eye() {
			translate([radius * 1.4, -3.1 * radius, radius * 5.9])
			rotate([66, 0, 15])
			linear_extrude(radius / 4, scale = 0.9)
				circle(radius * 1.15);
		}

		eye();

		mirror([1, 0, 0])
			eye();
			
		// nose
		if(nose) {
			translate([0, -3.75 * radius, radius * 4.85])
			rotate([67.5, 0, 0])
			linear_extrude(radius / 4, scale = 0.9)
				circle(radius * 0.4);
		}
	}
	
	if(smoothing) {
		minkowski() {
			union() {
				difference() {
					body();
					mask_face();	
				}
				eyes_nose();
			}
			sphere(radius / 9.5, $fn = 8);
		}
	} else {	
		difference() {
			body();
			mask_face();	
		}
		eyes_nose();
	}
}

module wish_decoration(text, font, font_size) {
    $fn = 48;
	
	translate([0, -2, 0])
	intersection() {
		union() {
			wish();

			decoration();
			mirror([1, 0, 0])
				decoration();
		}

		translate([0, 0, 31])
			sphere(52.25);
	}

	module wish() {
		if(len(text) == 1) {
			translate([0, -43, 21])
			rotate([90, 0, 0])
			linear_extrude(10, scale = .8, convexity = 10)
				text(
					text, 
					font = font,
					size = font_size,
					valign = "center", 
					halign = "center"
				);
		}
		else {
			translate([0, -43, 29.5])
			rotate([85, 0, 0])
			linear_extrude(10, scale = .8, convexity = 10)
				text(
					text[0], 
					font = font,
					size = font_size,
					valign = "center", 
					halign = "center"
				);
				
			translate([0, -42.5, 12])
			rotate([105, 0, 0])
			linear_extrude(10, scale = .8, convexity = 10)
				text(
					text[1], 
					font = font,
					size = font_size,
					valign = "center", 
					halign = "center"
				);
	    }
	}

	module decoration() {
		translate([18, -38, 21])
		rotate([100, 0, 0])
		linear_extrude(10, scale = .8)
		scale([.85, 1.55125])
		offset(.5)
		difference() {
			circle(10);
			translate([-9, 0])
				circle(11.5);
		}

		translate([28, -30, 21])
		rotate([100, 0, 30])
		linear_extrude(10, scale = .8)
		scale([.7, 1.2775])
		offset(.5)
		difference() {
			circle(10);
			translate([-9, 0])
				circle(11.5);
		}
	}
}
