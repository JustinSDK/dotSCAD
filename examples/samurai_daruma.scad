use <daruma.scad>
use <arc.scad>
use <polyline_join.scad>

text = "順暢";
font = "思源黑體 Medium";
font_size = 15;
nose = true;
model = "both"; // [daruma, helmet, both]

scale(.7) {
	if(model == "daruma") {
		difference() {
			union() {
				daruma(nose);
				wish_decoration(text, font, font_size);
			}
			translate([0, 0, -23])
			linear_extrude(20) 
				square(100, center = true);
		}

	} else if(model == "helmet") {
		scale(1.03)
			helmet();
	}
	else {
		difference() {
			union() {
				daruma(nose);
				wish_decoration(text, font, font_size);
			}
			translate([0, 0, -24.5])
			linear_extrude(20) 
				square(100, center = true);
		}

		translate([0, 4, 55])
		rotate([-20, 0, 0])
			helmet();
	}
}

module helmet() {
	scale([1.125, 1.2, .8]) {
		rotate_extrude($fn = 12)
			arc(radius = 41, angle = [0, 90], width = 3);
		
		rotate(-30)
		rotate_extrude(angle = 240, $fn = 12)
		polyline_join([[40.65, 1], [45, -10], [50, -30], [60, -45]])
		    circle(1.625, $fn = 4);

		translate([0, 0, 1])	
		linear_extrude(2)	
		difference() {
			translate([0, -20])
			scale([.9, 1])		
				circle(41, $fn = 8);
			circle(41);
		}	
		
		translate([0, 0, 3])	
		linear_extrude(2)	
		difference() {
			translate([0, -20])	
				circle(35, $fn = 8);
			circle(41, $fn = 12);
		}	
		
		translate([0, 0, 5])	
		linear_extrude(2)	
		difference() {
			translate([0, -20])	
				circle(30, $fn = 4);
			circle(41, $fn = 12);
		}	
		
		translate([0, -41, 12])	
		rotate([90, 0, 0])
		scale([1, 1.2, 0.35])
			sphere(10, $fn = 6);
			
		translate([0, -38, 67])
		rotate([90, 0, 0])	
		linear_extrude(2)
		difference() {
			circle(41 * 1.5, $fn = 12);
			translate([0, 14])
				circle(41 * 1.5);
		}
	}
	
	translate([-77, -26, -25])
	rotate([-1, 23, 30])
	linear_extrude(35)
	rotate([0, 0, -150])
	scale([0.75, 1])
		arc(radius = 30, angle = [0, 130], width = 2);

	mirror([1, 0, 0])
	translate([-77, -26, -25])
	rotate([-1, 23, 30])
	linear_extrude(35)
	rotate([0, 0, -150])
	scale([0.75, 1])
		arc(radius = 30, angle = [0, 130], width = 2);
}