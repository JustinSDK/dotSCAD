function _subdivide(triangles) = 
	[
		for(tri = triangles)
		each (tri[0] == "OBTUSE" ? _sub_obtuse(tri[1]) : _sub_acute(tri[1]))
	];

function _sub_acute(tri_shape) =
	let(
		a = tri_shape[0],
		b = tri_shape[1],
		c = tri_shape[2],
		PHI = 1.618033988749895,
		p = a + (b - a) / PHI
	)
	[["ACUTE", [c, p, b]], ["OBTUSE", [p, c, a]]];	
	
function _sub_obtuse(tri_shape) =
	let(
		a = tri_shape[0],
		b = tri_shape[1],
		c = tri_shape[2],
		PHI = 1.618033988749895,
		r = b + (c - b) / PHI
	) 
	[["OBTUSE", [r, c, a]], each _sub_acute([b, a, r])];

function _penrose3(triangles, n, i = 0) = 
	i == n ? triangles : _penrose3(_subdivide(triangles), n, i+ 1);
			
function tri2tile(type, tri) =
    let(
		tri1 = tri[1],
		tri2 = tri[2],
		m = 2 * (tri1 + tri2) / 2 - tri[0]
	)
	[[type, tri], [type, [m, tri1, tri2]]];

function _zRotation(a) = 
    let(c = cos(a), s = sin(a))
    [[c, -s], [s, c]]; 

function tile_penrose3(n, triangles) = 
    let(
		fn = 10,
		a = 720 / fn
	)
    _penrose3(
		is_undef(triangles) ? 
		    // star
			let(shape_tri0 = [[1, 0], [1, 0] + _zRotation(-180 + a) * [-1, 0], [0, 0]])
			[
				for(i = [0:fn / 2 - 1]) 
				let(m = _zRotation(i * a), t = [for(p = shape_tri0) m * p])
				each tri2tile("OBTUSE", t)
			] :
			[for(tri = triangles) each tri2tile(tri[0], tri[1])],
		n
	);

use <ptf/ptf_rotate.scad>;
use <polyline_join.scad>;

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

draw(tile_penrose3(5, [["OBTUSE", [[0, 0], [1, 0], ptf_rotate([1, 0], 108)]]]), radius);

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