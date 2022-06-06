use <ptf/ptf_rotate.scad>
use <polyline_join.scad>
use <shape_superformula.scad> 

function shape2wire(shape, r) = 
	let(
	    leng_shape = len(shape),
	    a = 360 / leng_shape
	)
	[
		for(i = [0:len(shape) - 1])
		let(p = shape[i])	
		ptf_rotate(
		    ptf_rotate([p[0], p[1], 0], [90, 0, 0]) + [r, 0, 0], 
		    a * i
		)
	];

phi_step = 0.05;
m = 16;
n = 0.5;
n3 = 16;
shape = shape_superformula(phi_step, m, m, n, n, n3) * 30;

translate([150, 0])
rotate([90, 0, 0])
linear_extrude(1, center = true)
difference() {
	square(120, center = true);
	polyline_join([each shape, shape[0]])
	    circle(2.5);
}

wire = shape2wire(shape, 150);
rotate(-$t * 360)
polyline_join([each wire, wire[0]])
	sphere(1.5);