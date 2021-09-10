use <__comm__/__frags.scad>;
use <sweep.scad>;

// e = 0;
// n = 0;

// $fn = 24;

// for(e = [0:.25:2]) {
//     for(n = [0:.25:3])
// 	    translate([e / .25, n / .25] * 3)
//         superellipsoid(e, n);
// }

module superellipsoid(e, n) {
	function _sgn(x) = 
		x < 0 ? -1 :
		x == 0 ? 0 : 
				 1; // x > 0

	function _c(w, m) = 
		let(cosw = cos(w))
			_sgn(cosw) * pow(abs(cosw), m);
		
	function _s(w, m) = 
		let(sinw = sin(w))
			_sgn(sinw) * pow(abs(sinw), m);
			
	a = 1;
	b = 1;
	c = 1;

	u_step = 360 / __frags(1);
	v_step = u_step / 2;

	sweep([
		for(v = [-90:v_step:90])
			[
				for(u = 180 - u_step; u >= -180; u = u - u_step)
				let(
					x = a * _c(v, n) * _c(u, e),
					y = b * _c(v, n) * _s(u, e),
					z = c * _s(v, n)
				)
				[x, y, z]
			]
	]);
}