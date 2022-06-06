use <crystal_ball.scad>
use <util/fibseq.scad>

spirals = 10;
petals_per_spiral = 4; 

module petal(radius, thickness) {
	translate([-radius * 1.5, 0, radius * 2]) 
    rotate([90, 120, 90]) 
    intersection() {
        crystal_ball(
            radius = radius * 2, 
            theta = 360,
            phi = 90,
            thickness = thickness
        );

		linear_extrude(radius * 5) hull() {
			translate([radius * 1.25, 0, 0]) circle(radius / 3);
			translate([-1.1 * radius, 0, 0]) circle(radius / 3);
			circle(radius * 0.85);
		}   
	}
}

module petals(fibseq, i = 0) {
    if(i < len(fibseq) - 1) {
        f1 = fibseq[i];
        f2 = fibseq[i + 1];
        offset = f1 - f2;
        translate([0, 0, offset * 1.8]) 
        rotate([-5, 40, 10])
            petal(-offset, -offset / 6);   

        translate([0, offset, 0]) 
        rotate(90) 
            petals(fibseq, i + 1);         
    }
}

module lotus_like_flower(spirals, petals_per_spiral) {
    step_angle = 360 / spirals;

    fibseq = fibseq(1, petals_per_spiral + 1);
    
    for(i = [0:spirals - 1]) { 
        rotate(i * step_angle)
            petals(fibseq);
    }

	fib_diff = fibseq[petals_per_spiral - 1] - fibseq[petals_per_spiral - 2];

	translate([0, 0, -fib_diff]) 
    scale([1, 1, fib_diff]) 
        sphere(1);
	
    translate([0, 0, -fib_diff * 2.25]) 
    crystal_ball(
        radius = fib_diff, 
        theta = 360,
        phi = 90
    );    
}

lotus_like_flower(spirals, petals_per_spiral + 1, $fn = 24);
