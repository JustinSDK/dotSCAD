use <polyline_join.scad>

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
	[["OBTUSE", r, c, a], each _sub_acute(b, a, r)];

function _penrose3(triangles, n, i = 0) = 
	i == n ? triangles : _penrose3(_subdivide(triangles), n, i+ 1);
			
function tri2tile(type, tri) =
    let(
		tri1 = tri[1],
		tri2 = tri[2],
	    c = (tri1 + tri2) / 2,
		v = c - tri[0],
		m = c + v
	)
	[[type, each tri], [type, m, tri1, tri2]];

function _zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [
        [c, -s],
        [s, c]
    ]; 

function tile_penrose3(n, triangles) = 
    let(
		fn = 10,
		a = 720 / fn,
		tris = _penrose3(
		    is_undef(triangles) ? 
			    // star
				let(shape_tri0 = [[1, 0], [1, 0] + _zRotation(-180 + a) * [-1, 0], [0, 0]])
				[
					for(i = [0:fn / 2 - 1]) 
					let(m = _zRotation(i * a), t = [for(p = shape_tri0) m * p])
					each tri2tile("OBTUSE", t)
				] :
            	[for(tri = triangles) let(t = tri[1]) each tri2tile(tri[0], [t[1], t[2], t[0]])],
		    n
		)
	)
    [for(t = tris) [t[0], [t[3], t[1], t[2]]]];

use <polyline_join.scad>
use <ptf/ptf_rotate.scad>

module draw(tris, radius) {
	for(t = tris) {
		color(t[0] == "OBTUSE" ? "white" : "black")
		linear_extrude(.5)
			polygon(t[1] * radius);
		linear_extrude(1)
		    polyline_join(t[1] * radius)
			    circle(.1);
	}
}

radius = 10;
$fn = 12;

draw(tile_penrose3(5, [
    ["OBTUSE", [ptf_rotate([2, 0], 108), [0, 0], [2, 0]]]
]), radius);

translate([40, 0])
    draw(tile_penrose3(0), radius);

translate([80, 0])
    draw(tile_penrose3(1), radius);

translate([0, -40])
    draw(tile_penrose3(2), radius);

translate([40, -40])
    draw(tile_penrose3(3), radius);

translate([80, -40])
    draw(tile_penrose3(4), radius);