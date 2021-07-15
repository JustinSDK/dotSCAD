use <ring_extrude.scad>;
use <arc_path.scad>;
use <shape_liquid_splitting.scad>;

$fn = 96;

twice_ring_extrude(
	arc_path(radius = 15, angle = [0, 120]), 
	r = 20, 
	shape_turns = 3
);

translate([100, 0])
twice_ring_extrude(
	shape_liquid_splitting(radius = 10, centre_dist = 30), 
	r = 30, 
	shape_turns = 4
);

module twice_ring_extrude(shape, r, shape_turns) {
	t = 360 * shape_turns;
	ring_extrude(shape, radius = r, twist = t, angle = 720);
}