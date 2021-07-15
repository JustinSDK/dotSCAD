use <ring_extrude.scad>;
use <arc_path.scad>;

$fn = 96;
r = 20;
number_of_turns = 1;

shape = arc_path(radius = 15, angle = [0, 120]);

cutted_donut(shape, r, number_of_turns) ;

module cutted_donut(shape, inner_r, number_of_turns) {
	t = 180 + 360 * number_of_turns;
	for(s = [shape, shape * -1]) {
		ring_extrude(s, radius = r, twist = t, angle = 360);
	}
}
