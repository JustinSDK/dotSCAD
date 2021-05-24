band_width = 145;
band_height = 24;
thickness = 1;
one_side_hook_numbers = 4;
t = "openhome.cc";
font_name = "Arial Black";
font_size = 6;

mask_hook();

module mask_hook() {
	module hook() {
		difference() {
			square([6, band_height * 0.95], center = true);
			translate([-band_height * 0.625, 0])
				circle(band_height / 1.5, $fn = 12);
		}
	}

    r = band_height * 0.225;
	x = band_width * 0.1425;
	y = band_height / 3.35;
	linear_extrude(thickness) {
		square([band_width, band_height * 0.6], center = true);

		hull() {
			translate([x, y])
				circle(r, $fn = 6);
			translate([-x, y])
				circle(r, $fn = 6);
			translate([-x, -y])
				circle(r, $fn = 6);
			translate([x, -y])
				circle(r, $fn = 6);
		}
	}

	linear_extrude(thickness * 2) {
		for(i = [0:one_side_hook_numbers - 1]) {
			tp = [band_width / 2 - 3 - 10 * i, 0];
			translate(tp)
				hook();
				
			mirror([1, 0, 0])
			translate(tp)
				hook();
		}
	}
	
	linear_extrude(thickness * 2)
	    text(t, font = font_name, size = font_size, valign="center", halign = "center");
}