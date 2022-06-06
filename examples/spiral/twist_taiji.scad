use <pie.scad>

radius = 15;
height = 90;
twist = 360;
spacing = 0.35;
$fn = 96;

animation_demo = "NO"; // [YES, NO]

if(animation_demo == "YES") {
    animation();
}
else {
	magatama(radius, height, "yang", spacing);
	translate([radius * 2, 0])
	    magatama_dot(radius, height, "ying", spacing);
}

module magatama(radius, height, type, spacing) {
	half_r = radius / 2;
	
	color(type == "ying" ? "DarkSlateGray" : "white")
	linear_extrude(height, twist = twist)
	difference() {
	    offset(r = -spacing)
		union() {
			difference() {
				pie(radius, [0, 180]);
				translate([-half_r, 0])
					circle(half_r);
			}
			translate([half_r, 0])
				circle(half_r);
		}
		
		translate([half_r, 0])
		offset(r = spacing)
		    circle(half_r / 3);
	}
}

module magatama_dot(radius, height, type, spacing = 0.4) {
	half_r = radius / 2;
	
	color(type == "ying" ? "black" : "white")
	linear_extrude(height, twist = twist)
	translate([half_r, 0])
	offset(r = -spacing)
		circle(half_r / 3);
}

module animation() {
	if($t <= 0.5) {
		magatama(radius, height, "ying", spacing);

		rotate($t * 2 * twist + 180)
		translate([0, 0, height - height * 2 * $t]) 
			magatama(radius, height, "yang", spacing);
	}
	else {
		magatama(radius, height, "ying", spacing);

		rotate(180) 
			magatama(radius, height, "yang", spacing);

		t = $t - 0.5;
		rotate(t * 2 * twist + 180) 
		translate([0, 0, height - height * 2 * t]) {
			magatama_dot(radius, height, "ying", spacing);
			rotate(180)
				magatama_dot(radius, height, "wang", spacing);
		}
	}
}