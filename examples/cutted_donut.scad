use <ring_extrude.scad>;

$fn = 96;
arc_a = 120;
arc_r = 15;
inner_r = 12;
number_of_turns = 1;

cutted_donut(arc_a, arc_r, inner_r, number_of_turns) ;

module cutted_donut(arc_a, arc_r, inner_r, number_of_turns) {

	arc_step = 360 / $fn;
	for(init_a = [0, 180]) {
		sh = [
			for(a = [0:arc_step:arc_a]) 
				[arc_r * cos(a + init_a) , arc_r * sin(a + init_a)]
		];
		ring_extrude(
			sh, 
			radius = arc_r + inner_r, 
			twist = 180 + 360 * number_of_turns, 
			angle = 360
		);
	}
}
