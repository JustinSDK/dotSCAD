use <ptf/ptf_rotate.scad>;
use <hull_polyline2d.scad>;

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
	let(
		PHI = 1.618033988749895,
		p = a + (b - a) / PHI
	)
	[[false, c, p, b], [true, p, c, a]];	
	
function _sub_a1(a, b, c) =
	let(
		PHI = 1.618033988749895,
		q = b + (a - b) / PHI,
		r = b + (c - b) / PHI
	)
	[[true, r, c, a], [true, q, r, b], [false, r, q, a]];

function _penrose3(triangles, n, i = 0) = 
	i == n ? triangles :
			_penrose3(_subdivide(triangles), n, i+ 1);
			
function tile_penrose3(n) = 
    let(
		a0 = 360 / $fn,
	    a2 = 180 - a0 * 2,
		shape_tri0 = [[0, 0], [1, 0], ptf_rotate([1, 0], a0)]
	)
    _penrose3([
		for(i = [0:$fn - 1]) 
		let(t = [for(p = shape_tri0) ptf_rotate(p, i * a0)])
		    i % 2 == 0 ? [false, t[0], t[1], t[2]] : [false, t[0], t[2], t[1]]
	], n);

module draw(tris) {
	for(t = tris) {
		color(t[0] ? "white" : "black")
		linear_extrude(.5))
			polygon([t[2], t[1], t[3]]);
		linear_extrude(1)
		    hull_polyline2d([t[2], t[1], t[3]], .1);
	}
}

radius = 10;
$fn = 12;

draw(tile_penrose3(0) * radius);

translate([30, 0])
    draw(tile_penrose3(1) * radius);

translate([60, 0])
    draw(tile_penrose3(2) * radius);

translate([0, -30])
    draw(tile_penrose3(3) * radius);

translate([30, -30])
    draw(tile_penrose3(4) * radius);

translate([60, -30])
    draw(tile_penrose3(5) * radius);