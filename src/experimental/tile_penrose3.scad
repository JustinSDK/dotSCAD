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
		each (type == "OBTUSE" ? _sub_obtuse(a, b, c) : _sub_acute(a, b, c))
	];

function _sub_acute(a, b, c) =
	let(
		PHI = 1.618033988749895,
		p = a + (b - a) / PHI
	)
	[["ACUTE", c, p, b], ["OBTUSE", p, c, a]];	
	
function _sub_obtuse(a, b, c) =
	let(
		PHI = 1.618033988749895,
		r = b + (c - b) / PHI
	) 
	concat([["OBTUSE", r, c, a]], _sub_acute(b, a, r));

function _penrose3(triangles, n, i = 0) = 
	i == n ? triangles :
			_penrose3(_subdivide(triangles), n, i+ 1);
			
function tile_penrose3(n, triangles) = 
    let(
		fn = 10,
		acute = 360 / fn,
		shape_tri0 = [[0, 0], [1, 0], ptf_rotate([1, 0], acute)],
		tris = _penrose3(
		    is_undef(triangles) ? [
				for(i = [0:fn - 1]) 
				let(t = [for(p = shape_tri0) ptf_rotate(p, i * acute)])
					i % 2 == 0 ? ["ACUTE", t[0], t[1], t[2]] : ["ACUTE", t[0], t[2], t[1]]
		    ] :
            [for(tri = triangles) [tri[0], tri[1][0], tri[1][1], tri[1][2]]],
		    n
		)
	)
    [for(t = tris) [t[0], [t[3], t[1], t[2]]]];

module draw(tris, radius) {
	for(t = tris) {
		color(t[0] == "OBTUSE" ? "white" : "black")
		linear_extrude(.5)
			polygon(t[1] * radius);
		linear_extrude(1)
		    hull_polyline2d(t[1] * radius, .1);
	}
}

radius = 10;

draw(tile_penrose3(6, [["ACUTE", [[0, 0], [1, 0], ptf_rotate([1, 0], 36)]]]), radius);

translate([30, 0])
    draw(tile_penrose3(1), radius);

translate([60, 0])
    draw(tile_penrose3(2), radius);

translate([0, -30])
    draw(tile_penrose3(3), radius);

translate([30, -30])
    draw(tile_penrose3(4), radius);

translate([60, -30])
    draw(tile_penrose3(5), radius);