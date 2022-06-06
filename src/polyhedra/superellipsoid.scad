/**
* superellipsoid.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-superellipsoid.html
*
**/

use <../__comm__/__frags.scad>
use <../sweep.scad>

module superellipsoid(e, n) {
	function _c(w, m) = 
		let(cosw = cos(w))
			sign(cosw) * pow(abs(cosw), m);
		
	function _s(w, m) = 
		let(sinw = sin(w))
			sign(sinw) * pow(abs(sinw), m);
			
	a = 1;
	b = 1;
	c = 1;

	a_step = 360 / __frags(1);

	sweep([
		for(v = [-90:a_step:90])
			[
				for(u = 180 - a_step; u >= -180; u = u - a_step)
				let(
					x = a * _c(v, n) * _c(u, e),
					y = b * _c(v, n) * _s(u, e),
					z = c * _s(v, n)
				)
				[x, y, z]
			]
	]);
}