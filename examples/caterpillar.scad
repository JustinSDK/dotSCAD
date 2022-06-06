use <arc.scad>
use <pie.scad>
use <hollow_out.scad>

$fn = 96;

module track(radius) {
	module wheels(radius) {
		module wheel() {
			rotate_extrude() 
			translate([radius, 0, 0]) 
				circle(radius / 2);
		}
		
		for(i = [0:4:8]) {
			translate([radius * i, 0, 0])
				wheel();
		}
	}
	
    module track_profile() {
        hull() {
			circle(1.7 * radius );
			translate([radius * 8, 0, 0]) 
				circle(1.7 * radius);
		}
	}

    translate([-radius * 4, 0, -radius])
	scale([1, 1, 1.5]) {
		color("black")
		linear_extrude(radius * 1.5)
		hollow_out(shell_thickness = 0.45 * radius)
		    track_profile();

		color("white") 
		translate([0, 0, radius * 0.75]) 
		scale([1, 1, 1.5]) 
		    wheels(radius);
	}
}

module body(radius) {
	module eye() {
		translate([-radius / 15, 0, 0]) 
		rotate([0, 0, 90]) 
			arc(radius / 2, [0, 180], radius / 5, width_mode = "LINE_OUTWARD");
				
		translate([0, radius / 3, 0]) 
			circle(radius / 3);
	}

	module eyebrow() {
		rotate([0, 0, 90]) 
			arc(radius / 1.25, [25, 155], radius / 10, width_mode = "LINE_OUTWARD");
	}

    scale([1, 1, 0.9]) {
		color("yellow") 
		    sphere(radius * 4);
		
		color("Aqua") 
		rotate([85, 0, 90]) 
		intersection() {
			linear_extrude(radius * 4.5) 
			    pie(radius * 3.5, [0, 180]);
			difference() {
				sphere(radius * 4 + radius / 5);
				sphere(radius * 4);
			}
		}
		
		// eyes
		color("black") {    
			rotate([0, 65, 16]) 
			linear_extrude(radius * 4.25)
				eye();
			
			rotate([0, 65, -16]) 
			linear_extrude(radius * 4.25) 
				eye();
		}
		
		// eyebrows
		color("black") {
			rotate([0, 55, 20]) 
			linear_extrude(radius * 4.25)
				eyebrow();
				
			rotate([0, 55, -20]) 
			linear_extrude(radius * 4.25) 
				eyebrow();				
		}
	}
}

module arm(radius) {
    translate([0, 0, -radius]) {
		translate([0, 0, radius / 2]) 
		linear_extrude(radius) {
			translate([0, -radius * 0.75, 0]) 
			    square([radius * 9, radius * 1.5]);

			rotate(80) 
			translate([0, -radius * 0.5, 0]) 
			    square([radius * 9, radius]);
		}

		translate([0, 0, radius * 0.25]) 
		linear_extrude(radius * 1.5) 
			circle(radius);
			
		linear_extrude(radius * 2)  
		translate([radius * 9, 0, 0]) 
			circle(radius);
	}
}

module glove(radius) {
    scale([0.8, 0.8, 1.2]) {
		color("white") {
			hull() {
				scale([1.1, 1, 0.5]) 
				    sphere(radius * 2.5);
					
				translate([-radius * 1.75, 0, radius / 1.5]) 
				scale([1, 1.75, 0.8]) 
				    sphere(radius);
			}

			translate([-radius * 2.5, 0, radius / 1.5]) 
			scale([1.2, 2, 1]) 
			    sphere(radius);

			rotate(-10)
			translate([0, -radius * 2.5, 0])  
			scale([1.75, 1, 0.8]) 
			    sphere(radius / 1.5);	
		}   
		
		color("black") 
		intersection() {
			scale([1.1, 1, 0.55]) 
			    sphere(radius * 2.5);
			
			union() {
				translate([0, radius * 0.75, -radius * 2])  
				linear_extrude(radius) 
					square([radius * 2, radius / 4], center = true);
				
				translate([0, -radius * 0.75, -radius * 2])  
				linear_extrude(radius) 
					square([radius * 2, radius / 4], center = true);				
			}
		}
	}
}

module big_caterpillar(radius) {
	translate([0, -radius * 4, 0]) 
	rotate([90, 0, 0]) 
	    track(radius);
	
	translate([0, 0, radius * 3]) 
	    body(radius);
	
	translate([0, radius * 4, 0]) 
	rotate([90, 0, 0]) 
	    track(radius);
	
	color("yellow") 
	translate([radius * 6, -radius * 4.5, radius * 9.5]) 
	rotate([90, 135, 0]) 
	    arm(radius);
	
	translate([radius * 10.75, -radius * 4.5, radius / 2.325]) 
	rotate([0, 70, 180]) 
	    glove(radius);
}

module small_caterpillar(radius) {
	body_pts = [
	    [0, 0, -radius / 3],
		[radius * 1.5, 0, 0],
		[radius * 3, 0, radius],
		[radius * 4.25, 0, radius * 2]
	];
	
	color("LimeGreen")
	for(p = body_pts) {
	    translate(p) 
		    sphere(radius);
	}

    module eye() {
		color("white") 
		translate([0, 0, 0]) 
		    sphere(radius / 1.5);

		color("black") 
		translate([.5 * radius, radius / 4, 0]) 
		    sphere(radius / 3);

		color("white") 
		translate([.655 * radius, radius / 2.75, 0])
		    sphere(radius / 6);
	}
	
	half_r = radius / 2;
	translate([radius * 4.75, 0, radius * 3]) {
	    translate([0, half_r, 0]) eye();
		translate([0, -half_r, 0]) eye();
	}
}

module caterpillars(radius) {
	big_caterpillar(radius);
	
	translate([radius * 3.5, -radius * 4.5, radius * 9.75]) 
	rotate([0, -15, 0]) 
	scale([0.8, 0.8, 0.8]) 
	    small_caterpillar(radius);
}

caterpillars(5);