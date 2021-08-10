use <ptf/ptf_rotate.scad>;
use <hull_polyline2d.scad>;
	
module tile_penrose3(radius, fn, n) {
	// triangle: [type, pa, pb pc], c: false(36) or true(108)
	PHI = 1.618033988749895; // golden ratio


	function _subdivide(triangles) = 
		[
			for(tri = triangles)
			let(
				type = tri[0],
				a = tri[1],
				b = tri[2],
				c = tri[3]
			)
			each (type ? _sub_a1(a, b, c) : _sub_a0(a, b, c))
		];

	function _sub_a0(a, b, c) =
		let(p = a + (b - a) / PHI)
		[[false, c, p, b], [true, p, c, a]];	
		
	function _sub_a1(a, b, c) =
		let(
			q = b + (a - b) / PHI,
			r = b + (c - b) / PHI
		)
		[[true, r, c, a], [true, q, r, b], [false, r, q, a]];

	function _penrose3(triangles, n, i = 0) = 
		i == n ? triangles :
				_penrose3(_subdivide(triangles), n, i+ 1);
				
			
	a0 = 360 / fn;
	a2 = 180 - a0 * 2;

	shape_tri0 = [[0, 0], [radius, 0], ptf_rotate([radius, 0], a0)];
	triangles = [
		for(i = [0:fn - 1]) 
		let(t = [for(p = shape_tri0) ptf_rotate(p, i * a0)])
		i % 2 == 0 ? [false, t[0], t[1], t[2]] : [false, t[0], t[2], t[1]]
	];
    tris = _penrose3(triangles, n);
	for(t = tris) {
		color(t[0] ? "white" : "black")
			polygon([t[2], t[1], t[3]]);
		linear_extrude(1)
		    hull_polyline2d([t[2], t[1], t[3]], .2);
	}
}

radius = 10;
fn = 12;

tile_penrose3(radius, fn, 0);

translate([30, 0])
    tile_penrose3(radius, fn, 1);

translate([60, 0])
    tile_penrose3(radius, fn, 2);

translate([0, -30])
    tile_penrose3(radius, fn, 3);

translate([30, -30])
    tile_penrose3(radius, fn, 4);

translate([60, -30])
    tile_penrose3(radius, fn, 5);