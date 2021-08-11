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
		each (type == "obtuse" ? _sub_obtuse(a, b, c) : _sub_acute(a, b, c))
	];

function _sub_acute(a, b, c) =
	let(
		PHI = 1.618033988749895,
		p = a + (b - a) / PHI
	)
	[["acute", c, p, b], ["obtuse", p, c, a]];	
	
function _sub_obtuse(a, b, c) =
	let(
		PHI = 1.618033988749895,
		q = b + (a - b) / PHI,
		r = b + (c - b) / PHI
	) 
	concat([["obtuse", r, c, a]], _sub_acute(b, a, r));

function _penrose3(triangles, n, i = 0) = 
	i == n ? triangles :
			_penrose3(_subdivide(triangles), n, i+ 1);
			
function tile_penrose3(n) = 
    let(
		acute = 360 / $fn,
		shape_tri0 = [[0, 0], [1, 0], ptf_rotate([1, 0], acute)],
		tris = _penrose3([
			for(i = [0:$fn - 1]) 
			let(t = [for(p = shape_tri0) ptf_rotate(p, i * acute)])
				i % 2 == 0 ? ["acute", t[0], t[1], t[2]] : ["acute", t[0], t[2], t[1]]
		], n)
	)
    [for(t = tris) [t[0], t[3], t[1], t[2]]];

module draw(tris) {
	for(t = tris) {
		color(t[0] == "obtuse" ? "white" : "black")
		linear_extrude(.5)
			polygon([t[1], t[2], t[3]] * radius);
		linear_extrude(1)
		    hull_polyline2d([t[1], t[2], t[3]] * radius, .1);
	}
}

radius = 10;
$fn = 12;

draw(tile_penrose3(0));

translate([30, 0])
    draw(tile_penrose3(1));

translate([60, 0])
    draw(tile_penrose3(2));

translate([0, -30])
    draw(tile_penrose3(3));

translate([30, -30])
    draw(tile_penrose3(4));

translate([60, -30])
    draw(tile_penrose3(5));