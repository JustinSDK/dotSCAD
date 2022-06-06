use <shape_pie.scad>
use <polyhedron_hull.scad>
use <util/rand.scad>
use <experimental/worley_sphere.scad>

base_r = 10;
crystals = 10;
crystal_cluster(base_r, crystals);

module crystal_cluster(base_r, crystals) {
	module single_crystal(r) {
		h = r * 6;

		bottom_shape = shape_pie(
			rand(r * 0.85, r * 1.15), 
			[rand(0, 15), rand(345, 360)], 
			$fn = 6
		);
		neck_shape = shape_pie(
			rand(r * 0.85, r * 1.15), 
			[15, 356], 
			$fn = 6
		);

		polyhedron_hull(
			[
				each [for(p = bottom_shape) [p.x, p.y, 0]],
				each [for(p = neck_shape) [p.x, p.y, rand(h * 0.7, h * 0.75)]],
				[rand(0, r * 0.1), rand(0, r * 0.1), rand(h * 0.8, h)],
				each [for(i = [0:2]) if(rand(0, 1) > 0.5) [rand(0, r * 0.15), rand(0, r * 0.15), rand(h * 0.9, h * 1.05)]]
			]
		);
	}
    
	module rock(radius, detail) {
		detail = detail;
		amplitude = .25;
		dist = "border"; 
		
		scale([1, 1, 0.5])
		difference() {
			translate([0, 0, 5.1])
				worley_sphere(radius, detail, amplitude, dist);

			translate([0, 0, -30]) 
			linear_extrude(30)
				square(radius * 10, center = true);
		}
	}


	translate([0, 0, base_r * 0.5])
	for(i = [0:crystals]) {
		seed_r = base_r * rand(0, 0.75);
		seed_a = rand(0, 360);
		seed_pt = seed_r * [cos(seed_a), sin(seed_a)];

		translate(seed_pt)
		rotate([0, rand(0, 120 * seed_r / base_r), seed_a])
			single_crystal(base_r - seed_r);
	}

	rock(base_r * 1.45, 1);
}
