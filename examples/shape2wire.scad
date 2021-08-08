use <ptf/ptf_rotate.scad>;
use <hull_polyline2d.scad>;
use <hull_polyline3d.scad>;
use <shape_superformula.scad>; 

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
	hull_polyline2d(concat(shape, [shape[0]]), width = 5);
}

wire = shape2wire(shape, 150);
rotate(-$t * 360)
    hull_polyline3d(concat(wire, [wire[0]]), 3);