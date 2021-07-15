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
	shape_liquid_splitting(radius = 5, centre_dist = 25), 
	r = 25, 
	shape_turns = 4
);

translate([-95, 0])
twice_ring_extrude(
	[[17.5, 0], [17.5, 10], [12.5, 10], [12.5, 5], [7.5, 5], [7.5, 10], [2.5, 10], [2.5, 5], [-2.5, 5], [-2.5, 10], [-7.5, 10], [-7.5, 5], [-12.5, 5], [-12.5, 10], [-12.5, 10], [-17.5, 10], [-17.5, 0]], 
	r = 25, 
	shape_turns = 3
);

module twice_ring_extrude(shape, r, shape_turns) {
	t = 360 * shape_turns;
	ring_extrude(shape, radius = r, twist = t, angle = 720);
}