use <ring_extrude.scad>;
use <arc_path.scad>;

$fn = 96;
r = 20;
shape_turns = 3;

shape = arc_path(radius = 15, angle = [0, 120]);

twice_ring_extrude(shape, r, shape_turns) ;

module twice_ring_extrude(shape, r, shape_turns) {
	t = 360 * shape_turns;
	ring_extrude(shape, radius = r, twist = t, angle = 720);
}