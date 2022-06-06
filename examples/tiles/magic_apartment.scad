use <rounded_square.scad>
use <util/choose.scad>
use <util/rand.scad>

width = 25;
rows = 1;
columns = 3;
floors = 2;
up_down_rand = true;
people = true;

magic_apartment(width, rows, columns, floors, up_down_rand, people);

module magic_apartment(width, rows, columns, floors, up_down_rand, people) {
    // based on wang tiles, 3D version
	edges = [
		for(z = [0:floors])
		[
			for(y = [0:rows])
			[
				for(x = [0:columns]) 
				let(rs = rands(0, 1, 3))
				[round(rs[0]), round(rs[1]), round(rs[2])]
			]
		]
	];

	translate([0, 0, width / 4 + width / 30])
	scale([1, 1, 0.5])
	for(z = [0:floors - 1], y = [0:rows - 1], x = [0:columns - 1]) {
		translate([x * width, y * width, z * width])
		tile(width, [
			edges[z][y][x][0], edges[z][y][x + 1][1], edges[z][y + 1][x][0], edges[z][y][x][1],
			edges[z + 1][y][x][0], edges[z + 1][y][x + 1][1], edges[z + 1][y + 1][x][0], edges[z + 1][y][x][1],
		], up_down_rand);
	}

    // base
	linear_extrude(width / 30)
		square([width * columns, width * rows]);

    // walls
	translate([0, width * rows])
	difference() {
		linear_extrude(width * floors / 2 + width / 15)
			square([width * columns, width / 30]);
	    
		for(f = [1:2:floors * 4 - 1], c = [1:2:columns * 4 - 1]) {
			if(choose([true, false])) {
				translate([width / 4 * c, 0, width / 8 * f]) 
					cube([rand(width / 15, width / 15 * 2) , width / 15, rand(width / 15, width / 15 * 3)], center = true);
			}
		}
	}

	translate([-width / 30, 0])
	difference() {
		linear_extrude(width * floors / 2 + width / 15)
			square([width / 30, width * rows + width / 30]);
		for(f = [1:2:floors * 4 - 1], r = [1:2:rows * 4 - 1]) {
			if(choose([true, false])) {
				translate([0, width / 4 * r, width / 8 * f]) 
					cube([width / 15, rand(width / 15, width / 15 * 2), rand(width / 15, width / 15 * 3)], center = true);
			}
		}
	}

	// tiles, just quick and dirty 
	module tile(width, edges, up_down_rand) {
		// Webdings
		symbols = ["", "", "", "", "", "", ""];
		half_w = width / 2;
		one_third_w = width / 3;
		one_sixth_w = width / 6;
		t = one_third_w / 5;
		double_t = t * 2;
		half_t = t / 2;
		
		module stairs() {
			w = one_third_w / 2;
			
			// down stairs
			for(i = [0:3]) {
				if(edges[i] == 1) {
					rotate(90 * i) {
						translate([-w / 2, 0, 0]) {
							hull() {
								translate([0, -one_sixth_w - half_t, 0])
									cube([w * 0.75, t, t], center = true);
								translate([0, -half_w + t, -half_w])
									cube([w * 0.75, t, t], center = true);
							}

							if(up_down_rand && choose([true, false])) {
								for(j = [0:6]) {
									translate([0, -one_sixth_w - half_t * j, -t * (j + 1)])
										cube([w * 0.75, t, t], center = true);
								}
							} else {
								for(j = [0:6]) {
									translate([0, -one_sixth_w - t - half_t * j, -t * j])
										cube([w * 0.75, t, t], center = true);
								}
							}
						}
						
						translate([0, -half_w + t, -half_w])
							cube([w * 1.5 + one_sixth_w / 4, t * 2, double_t], center = true);
					}
				}
				else if(edges[i + 4] == 0) {
					rotate(90 * i)
					hull() {
						translate([0, -one_sixth_w, 0])
							cube([w, t, double_t], center = true);
						translate([0, -half_w + half_t , 0])
							cube([w, t, double_t], center = true);
					}
						
				}
			}
			
			// up stairs
			for(i = [4:7]) {
				if(edges[i] == 1) {
					rotate(90 * i) {
						translate([w / 2, 0, 0]) {
							hull() {
								translate([0, -one_sixth_w - half_t, 0])
									cube([w * 0.75, t, t], center = true);
								translate([0, -half_w + t, half_w])
									cube([w * 0.75, t, t], center = true);
							}
							
							if(up_down_rand && choose([true, false])) {
								for(j = [0:6]) {
									translate([0, -one_sixth_w - half_t * (j + 2), t * (j + 1) - t])
										cube([w * 0.75, t, t], center = true);
								}
							}
							else {
								for(j = [0:6]) {
									translate([0, -one_sixth_w - half_t * (j + 1), t * (j + 1) + t])
										cube([w * 0.75, t, t], center = true);
								}
							}
						}
						
						translate([0, -half_w + t, half_w])
							cube([w * 1.5 + one_sixth_w / 4, t * 2, double_t], center = true);
					}
				}
			}
		}

		translate([half_w, half_w]) {
			stairs();
			linear_extrude(t * 3, center = true)
				rounded_square(size = [one_third_w + double_t, one_third_w + double_t, t], corner_r = 2, center = true, $fn = 24);
			
			if(people) {
				// people
				mirror([0, 0, up_down_rand && choose([true, false]) ? 1 : 0])
				translate([0, 0, t * 1.5])
				rotate([90, 0, rand(0, 359)])
				linear_extrude(half_t)
				scale([1, 2])
					text(font = "Webdings", choose(symbols), size = width / 5.5, halign = "center");
			}
		}
	}
}