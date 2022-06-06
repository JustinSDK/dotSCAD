use <polyhedron_hull.scad>
use <sweep.scad>
use <shape_trapezium.scad>
use <util/slice.scad>
use <util/sub_str.scad>
use <ptf/ptf_rotate.scad>

emoticon = "ToT";
font = ["Arial Black", "Arial Black", "Arial Black"];
font_size = [7.5, 9, 7.5];

h = 50;
face = 15;
face_step = 3;
nose = 3;
nose_step = 1;

smoothing = false; // warning: previewing is slow if it's true.
smoothing_r = 2;
$fn = 12;

color("DarkGray")
if(smoothing) {
	minkowski() {
		translate([0, h / 2, 0])
			emoticon_moai(emoticon, font, font_size, h, face, face_step, nose, nose_step);
		sphere(smoothing_r);
	}
}
else {
	translate([0, h / 2, 0])
		emoticon_moai(emoticon, font, font_size, h, face, face_step, nose, nose_step);
}

/*
	translate([50, h / 2, 0])
			emoticon_moai("@xO", font, font_size, h, face, face_step, nose, nose_step);

	translate([-50, h / 2, 0])
			emoticon_moai("$___$", font, font_size, h, face, face_step, nose, nose_step);
*/

module emoticon_moai(emoticon, font, font_size, h, face = 18, face_step = 3, nose = 4, nose_step = 1) {
	profile = [
	    for(p = [
			// back
			[0, 0, 0],
			[0, 0, h * 0.25],
			[0, -h / 25, h * 0.45],
			[0, -h / 20, h / 2],
			[0, -h / 40, h / 4 * 3],
			[0, h / 20, h],
			// head : 6
			[0, -h / 10, h * 1.05],
			[0, -h / 5, h * 1.075],
			[0, -h / 3.2, h * 0.94],
			[0, -h / 3.5, h * 0.9],
			// nose : 10
			[0, -h / 2.4, h * 0.75],
			[0, -h / 2, h * 0.7],
			[0, -h / 2, h * 0.65],
			// mouth : 13
			[0, -h / 2.25, h * 0.625],
			[0, -h / 2.175, h * 0.6],
			[0, -h / 2.05, h * 0.55],
			[0, -h / 2, h * 0.5],
			[0, -h / 2, h * 0.46],
			[0, -h / 2.05, h * 0.425],
			[0, -h / 2.15, h * 0.4],
			[0, -h / 2.5, h * 0.375],
			[0, -h / 2, h * 0.25],
			[0, -h / 1.75, 0],
		]) p + [0, -h / 2.5, 0]
	];

	no_nose_profile = concat(slice(profile, 0, 10), slice(profile, 13));
	no_nose_sections = concat(
		[
			[
				for(i = [0:len(no_nose_profile) - 1])
				let(
					p = no_nose_profile[i],
					rp = ptf_rotate([p[0] * 0.8, p[1] * 0.4, p[2] * 0.85] + [1, -13, 0], face + face_step)
				)
				[rp[0], rp[1], rp[2] == 0 ? rp[2] : rp[2] + 3] + [1, 0, 0]
			],
			[
				for(i = [0:len(no_nose_profile) - 1])
				let(
					p = no_nose_profile[i],
					rp = ptf_rotate([p[0] * 0.85, p[1] * 0.8, p[2] * 0.96] + [0, -6, 0], face + face_step * 1.1)
				)
				[rp[0], rp[1], rp[2] == 0 ? rp[2] : rp[2] + 1]
			]
		],
		[
			for(a = face; a >= 0; a = a - face_step) 
				[for(i = [0:len(no_nose_profile) - 1])
					ptf_rotate(no_nose_profile[i], a)]
		]
	);

	back = [
		for(section = no_nose_sections)
		each slice(section, 0, 6)
	];
	
    nose_profile = slice(profile, 9, 14); 
	nose_sections = [
		for(a = nose; a >= 0; a = a - nose_step) 
			[for(i = [0:len(nose_profile) - 1])
				ptf_rotate(nose_profile[i], a)]
	];
	
	polyhedron_hull(
		concat(back, [for(p = back) [-p[0], p[1], p[2]]]), 
		polyhedron_abuse = true
	);

    module ear() {
		translate([h / 17, -h / 6, 0])
        rotate([0, 0, face * 1.5])
		translate([0, -h / 2.5, h / 1.45])
		rotate([90, face, 90])
		linear_extrude(h / 25, center = true, scale = .9)
		polygon(
			shape_trapezium([h * 0.125, h * 0.075], 
			h = h * 0.425,
			corner_r = h / 40)
		);
	}

    module head() {
		sweep(no_nose_sections);
		
		translate([0, .01, 0]) 
			sweep(nose_sections);
		
		ear();
	}

	head();
	mirror([1, 0, 0])
	    head();

	hull() {
	    translate([0, h / 7.5, 0])
		scale([1.25, 1.2, 1])
		intersection() {
		    union() {
				sweep(no_nose_sections);
				mirror([1, 0, 0])
					sweep(no_nose_sections);
			}
			translate([0, -h / 2, 0])
				cube([h / 2 * 2, h / 2 * 2, h * 0.8 / 2], center = true);		
		}
		
		scale([1, 1, 1])
		intersection() {
		    union() {
				sweep(no_nose_sections);
				mirror([1, 0, 0])
					sweep(no_nose_sections);
			}
			translate([0, -h / 2, 0])
				cube([h / 2 * 2, h / 2 * 2, h * 1.25 / 2], center = true);		
		}	
	}
	
	translate([0, -h / 3, h / 7])
	rotate([0, 0, -nose * 5])
	translate([0, -h / 2.5, h / 1.45])
	rotate([60, 0, (face + nose) / 2])
    linear_extrude(h / 25, center = true, scale = .9)
	    text(emoticon[0], font = font[0], size = font_size[0], valign = "center", halign = "center");

	translate([0, -h / 1.13, h / 1.85])
	rotate([70, 0, 0])
    linear_extrude(h / 25, center = true, scale = .9)
	    text(sub_str(emoticon, 1, len(emoticon) - 1), font = font[1], size = font_size[1], valign = "center", halign = "center");
		
	translate([0, -h / 3, h / 7])
	rotate([0, 0, nose * 5])
	translate([0, -h / 2.5, h / 1.45])
	rotate([60, 0, -(face + nose) / 2])
    linear_extrude(h / 25, center = true, scale = .9)
	    text(emoticon[len(emoticon) - 1], font = font[2], size = font_size[2], valign = "center", halign = "center");
}