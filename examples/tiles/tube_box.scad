use <experimental/tile_w2e.scad>
use <select.scad>
use <box_extrude.scad>

size = [15, 8];
tile_width = 10;
$fn = 12;

tube_box(size, tile_width);

module tube_box(size, tile_width) {
    half_w = tile_width / 2;
	quarter_w = tile_width / 4;
	eighth_w = tile_width / 8;
	
    translate([eighth_w, eighth_w, eighth_w] + [tile_width, tile_width, 0] / 2)
		for(tile = tile_w2e(size)) {
			translate([tile.x, tile.y] * tile_width)
				tube_tile(tile[2], tile_width);
		}

	box_extrude(height = tile_width, shell_thickness = eighth_w)
		square([size[0] * tile_width + quarter_w, size[1] * tile_width + quarter_w]);
}

module tube_tile(n, width) {
    half_w = width / 2;
	quarter_w = width / 4;
	sixteenth_w = width / 16;

	module tile0() {
		difference() {
			union() {
				linear_extrude(width / 2)
				circle(quarter_w);
				
				translate([0, 0, half_w])
				linear_extrude(sixteenth_w, center = true)
					circle(quarter_w * 1.2);

				linear_extrude(sixteenth_w, center = true)
					circle(quarter_w * 1.2);
			}

			linear_extrude(width)
				circle(quarter_w - quarter_w * 0.2);
		}
	}
		
	module tile1() {
	    translate([0, half_w])
	    rotate([90, 0, -90]) {
			rotate_extrude(angle = 90)
			translate([half_w, 0])
			circle(quarter_w);
			
			translate([half_w, 0])
			rotate([90, 0, 0])
			linear_extrude(sixteenth_w, center = true)
				circle(quarter_w * 1.2);
				
			translate([0, half_w])
			rotate([0, 90, 0])
			linear_extrude(sixteenth_w, center = true)
				circle(quarter_w * 1.2);
	    }
	}
	
	module tile3() {
	    mirror([1, 0, 0])
	    translate([-half_w, 0, half_w])
        rotate([0, 90, 0])
		    tile1();
	}

	module tile5() {
	    translate([0, 0, half_w])
	    rotate([90, 0, 0]) {
			linear_extrude(width, center = true)
			circle(quarter_w);
			
			translate([0, 0, half_w])
			linear_extrude(sixteenth_w, center = true)
				circle(quarter_w * 1.2);
				
			translate([0, 0, -half_w])
			linear_extrude(sixteenth_w, center = true)
				circle(quarter_w * 1.2);
		}
	}
	
	module tile7() {
        tile5();
		
		translate([0, 0, half_w])
		rotate([0, 90, 0]) {
			linear_extrude(half_w)
			circle(quarter_w);
			
			translate([0, 0, half_w])
			linear_extrude(sixteenth_w, center = true)
				circle(quarter_w * 1.2);
		}
	}
	
	module tile15() {
	    tile5();
		rotate(90)
		tile5();
	}

	select(n) {
		tile0();
		tile1();
		rotate(-90) tile1();
		tile3();
		rotate(-180) tile1();
		tile5();
		rotate(-90) tile3();
		tile7();
		rotate(90) tile1();
		rotate(90) tile3();
		rotate(90) tile5();
		rotate(90) tile7();
		rotate(-180) tile3();
		rotate(180) tile7();
		rotate(270) tile7();
		tile15();
	}
}