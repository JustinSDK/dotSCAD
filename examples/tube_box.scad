use <box_extrude.scad>;

rows = 8;
columns = 15;
tile_width = 10;
tile_thickness = 2;
$fn = 12;

module two_edge_wang_tiles(rows, columns, tile_width) {
	edges = [
		for(y = [0:rows])
		[
			for(x = [0:columns]) 
			[round(rands(0, 1, 1)[0]), round(rands(0, 1, 1)[0])]
		]
	];

	for(y = [0:rows - 1]) {
		for(x = [0:columns - 1]) {
			i = (edges[y + 1][x][0] == 1 ? 1 : 0) +
			(edges[y][x + 1][1] == 1 ? 2 : 0) +
			(edges[y][x][0] == 1 ? 4 : 0) +
			(edges[y][x][1] == 1 ? 8 : 0);
			translate([x, y] * tile_width)
				children(i);
		}
	}
}

two_edge_wang_tiles(rows, columns, tile_width) {
	tube_tile(0, tile_width);
	tube_tile(1, tile_width);
	tube_tile(2, tile_width);
	tube_tile(3, tile_width);
	tube_tile(4, tile_width);
	tube_tile(5, tile_width);
	tube_tile(6, tile_width);
	tube_tile(7, tile_width);
	tube_tile(8, tile_width);
	tube_tile(9, tile_width);
	tube_tile(10, tile_width);
	tube_tile(11, tile_width);
	tube_tile(12, tile_width);
	tube_tile(13, tile_width);
	tube_tile(14, tile_width);
	tube_tile(15, tile_width);
}

translate([-tile_width / 2 - tile_width / 8, -tile_width / 2 - tile_width / 8, -tile_width / 8])
box_extrude(height = tile_width, shell_thickness = tile_width / 8)
square([columns * tile_width + tile_width / 4, rows * tile_width + tile_width / 4]);

module tube_tile(n, width) {
    half_w = width / 2;
	quarter_w = width / 4;
	sixteenth_w = width / 16;
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
	
	if(n == 0) {
	    // no tube
	}
	else if(n == 1) {
		tile1();
	}
	else if(n == 2) {
	    rotate(-90) tile1();
	}
	else if(n == 3) {
	    tile3();
	}
	else if(n == 4) {
	    rotate(-180) tile1();
	}
	else if(n == 5) {
	    tile5();
	}
	else if(n == 6) {
	    rotate(-90) tile3();
	}
	else if(n == 7) {
	    tile7();
	}
	else if(n == 8) {
	    rotate(90) tile1();
	}
	else if(n == 9) {
	    rotate(90) tile3();
	}
	else if(n == 10) {
	    rotate(90) tile5();
	}
	else if(n == 11) {
	    rotate(90) tile7();
	}
	else if(n == 12) {
	    rotate(-180) tile3();
	}
	else if(n == 13) {
	    rotate(180) tile7();
	}
	else if(n == 14) {
	    rotate(270) tile7();
	}
	else if(n == 15) {
	    tile15();
	}
}