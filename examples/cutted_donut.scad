use <ring_extrude.scad>;

$fn = 96;
inner_r = 12;
number_of_turns = 1;


arc_a = 120;
arc_r = 15;
shape = [
	for(a = [0:360 / $fn:arc_a]) 
		[arc_r * cos(a) , arc_r * sin(a)]
];

cutted_donut(shape, inner_r, number_of_turns) ;

module cutted_donut(shape, inner_r, number_of_turns) {
	r = arc_r + inner_r;
	t = 180 + 360 * number_of_turns;
	for(s = [shape, shape * -1]) {
		ring_extrude(s, radius = r, twist = t, angle = 360);
	}
}
