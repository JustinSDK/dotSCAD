use <ptf/ptf_rotate.scad>;
use <hull_polyline2d.scad>;

// triangle: [type, pa, pb pc], c: false(36) or true(108)

PHI = 1.618033988749895; // golden ratio

n = 12;

a0 = 360 / n;
a2 = 180 - a0 * 2;

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
			
			
module tile_penrose3(triangles, n) {
    tris = _penrose3(triangles, n);
	for(t = tris) {
		color(t[0] ? "white" : "black")
			polygon([t[2], t[1], t[3]]);
		linear_extrude(1)
		    hull_polyline2d([t[2], t[1], t[3]], .2);
	}
}

side = 10;

shape_tri0 = [[0, 0], [side, 0], ptf_rotate([side, 0], a0)];
triangles = [
    for(i = [0:n - 1]) 
	let(t = [for(p = shape_tri0) ptf_rotate(p, i * a0)])
	i % 2 == 0 ? [false, t[0], t[1], t[2]] : [false, t[0], t[2], t[1]]
];

tile_penrose3(triangles, 0);

translate([30, 0])
    tile_penrose3(triangles, 1);

translate([60, 0])
    tile_penrose3(triangles, 2);

translate([0, -30])
    tile_penrose3(triangles, 3);

translate([30, -30])
    tile_penrose3(triangles, 4);

translate([60, -30])
    tile_penrose3(triangles, 5);