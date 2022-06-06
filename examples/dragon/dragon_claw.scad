use <curve.scad>
use <ptf/ptf_rotate.scad>
use <util/dedup.scad>

module dragon_claw() {
	pts = [
		[0, 0.55], [1, 0.45], [2.5, 0.375], [6, 0.825], [8, -0.375], 
		[8, -0.375], [6, 1.875], [4, 1.6], [1.8, 2.5], [1.5, 2.8], [1.2, 3.3], [1.05, 3.8], [1, 4], [0, 8]
	];

	$fn = 16;

	a = 360 / $fn;
	x = 6.2 * cos(a);
	y = 6.2 * sin(a);
	path = [
		[0, 0], [2.5, 0], [x, y], [x + 1, y + 1]
	];
	path2 = [
		for(i = len(path) - 1; i > -1; i = i - 1) 
			ptf_rotate([path[i][0], -path[i][1]], a * 2)
	];

	t_step = 0.25;
	claw_path_basic = concat(curve(t_step, path), curve(t_step, path2));
	claw_path1 = [for(p = claw_path_basic) [p[0] * 1.15, p[1] * 1.1]];
	claw_path2 = [for(p = claw_path_basic) ptf_rotate(p * 1.2, a * 2)];
	claw_path3 = [for(p = claw_path_basic) ptf_rotate(p * 1.15, a * 4)];
	claw_path4 = [for(p = claw_path_basic) ptf_rotate(p * 1.1, a * 6)];
	claw_path5 = [for(p = claw_path_basic) ptf_rotate(p, a * 11)];

	rotate(-15)
	scale([1.15, 1.3, 1]) 
	rotate(15)
	intersection() {
		rotate_extrude($fn = 7)
			polygon(pts);
		linear_extrude(5)
			polygon(
				dedup(
					[
						each claw_path1, 
						each claw_path2, 
						each claw_path3, 
						each claw_path4, 
						[-2, -.75], 
						[-1.45, -1.45], 
						each claw_path5, 
						[1.45, -1.45], 
						[2, -.75]
					]
				)
			);
	}
}