use <ring_extrude.scad>;
use <arc_path.scad>;
use <shape_liquid_splitting.scad>;

$fn = 96;

twice_ring_extrude(
	arc_path(radius = 20, angle = [0, 120]), 
	r = 25, 
	shape_turns = 5
);

translate([95, 0])
twice_ring_extrude(
	[for(p = shape_liquid_splitting(radius = 5, centre_dist = 25)) [p[0], p[1] + 10]], 
	r = 25, 
	shape_turns = 3
);

translate([-110, 0])
twice_ring_extrude(
	[[17.5, 10], [17.5, 20], [12.5, 20], [12.5, 15], [7.5, 15], [7.5, 20], [2.5, 20], [2.5, 15], [-2.5, 15], [-2.5, 20], [-7.5, 20], [-7.5, 15], [-12.5, 15], [-12.5, 20], [-17.5, 20], [-17.5, 10]], 
	r = 30, 
	shape_turns = 3
);

module twice_ring_extrude(shape, r, shape_turns) {
	t = 360 * shape_turns;
	ring_extrude(shape, radius = r, twist = t, angle = 720);
}