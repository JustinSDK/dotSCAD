use <line2d.scad>
use <polyhedra/star.scad>
use <util/rand.scad>

base = 100;
segments = 150;

xmas_tree(base, segments);

module xmas_tree(base, segments) {
	half_base = base / 2;
	height = PI * half_base;
	slope = height / half_base;
	dx = half_base / segments;
	dh = height / segments;
	a = dh / (2 * PI * half_base) * 360 * 3;
	base_h = dh * 2;
	seg_w = base_h * 3;

	for(i = [0:segments]) {
		x = i * dx - half_base;
		
		color(c = [0, rand(), 0])
		rotate(a * i)
		translate([0, 0, dx * i * slope + base_h])
		linear_extrude(dh)
			line2d([x, 0], [-x, 0], width = seg_w);
	}

	color("Sienna")
	linear_extrude(base_h)
		circle(half_base + base_h + seg_w, $fn = 48);

	color("yellow")
	translate([0, 0, height + dh * 6])
	rotate([90, 0, 540]) {
		star(seg_w * 2.75, seg_w * 1.5, seg_w, 8);
		mirror([0, 0, 1]) star(seg_w * 2.75, seg_w * 1.5, seg_w, 8);
	}
}