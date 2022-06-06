use <util/dedup.scad>

// tile type
KITE = 0;
DART = 1;

function tile(type, x, y, angle, size) = [type, x, y, angle, size];
function tile_type(t) = t[0];
function tile_x(t) = t[1];
function tile_y(t) = t[2];
function tile_angle(t) = t[3];
function tile_size(t) = t[4];

tile_eq = function(t1, t2, epsilon = 0.0001) 
    abs(tile_x(t1) - tile_x(t2)) < epsilon && 
	abs(tile_y(t1) - tile_y(t2)) < epsilon && 
	tile_angle(t1) == tile_angle(t2);
	
tile_hash = function(t) tile_type(t) + tile_angle(t);

function between_360(a) = 
    a >= 360 ? a - 360 :
	a < 0 ? a + 360 :
	a;


function sub_kite(tile) = 
	let(
	    PHI = 1.618033988749895,
	    x = tile_x(tile),
		y = tile_y(tile),
		angle = tile_angle(tile),
		size = tile_size(tile),
		n_size = tile_size(tile) / PHI,
		r = PHI * size
	)
	[
		for(i = 0, sign = 1; i < 2; i = i + 1, sign = -sign)
		let(a = angle - 36 * sign)
		each [
			tile(
				DART,
				x,
				y,
				between_360(angle - 4 * 36 * sign),
				n_size
			),
			tile(
				KITE,
				x + r * cos(a),
				y + r * sin(a),
				between_360(angle + 3 * 36 * sign),
				n_size
			)
		]
	];
	
function sub_dart(tile) = 
	let(
	    PHI = 1.618033988749895,
	    x = tile_x(tile),
		y = tile_y(tile),
		angle = tile_angle(tile),
		size = tile_size(tile),
		n_size = tile_size(tile) / PHI,
		r = PHI * size
	)
	[
		tile(KITE, x, y, between_360(angle + 5 * 36), n_size),
		each [
			for(i = 0, sign = 1; i < 2; i = i + 1, sign = -sign)
			let(a = between_360(angle - 4 * 36 * sign))
			tile(
			    DART,
				x + r * cos(a),
				y + r * sin(a),
				a,
				n_size
			)
		]
	];

function subdivide(tiles) = [
    for(tile = tiles)
	each (tile_type(tile) == DART ? sub_dart(tile) : sub_kite(tile))
];

function tri2tile(type, tri) =
    let(
		v = tri[1] - tri[0],
		a = atan2(v[1], v[0]) + 36
	)
	tile(type, tri[0][0], tri[0][1], a, 1);

function _penrose2(tiles, n, i = 0) = 
	i == n ? tiles :
			_penrose2(dedup(subdivide(tiles), eq = tile_eq, hash = tile_hash), n, i + 1);
			
function tile_penrose2(n, triangles) = 
    let(
	    tiles = _penrose2(
		    is_undef(triangles) ?
		        [for(i = [0:4]) tile(KITE, 0, 0, 36 * (1 + 2 * i), 1)] : [for(tri = triangles) tri2tile(tri[0], tri[1])], 
			n
		),
		PHI = 1.618033988749895,
	    dist = [[PHI, PHI, PHI], [-PHI, -1, -PHI]]
	)
	[
	    for(tile = tiles)
		let(
			angle = tile_angle(tile) - 36,
			type = tile_type(tile),
			size = tile_size(tile),
			shape = [
				[tile_x(tile), tile_y(tile)],
				each [
					for(i = [0:2])
					let(
						r = dist[type][i] * size,
						a = angle + i * 36
					)
					[tile_x(tile) + r * cos(a), tile_y(tile) + r * sin(a)]
				]
			]
		)
		each [
		    [type, [shape[0], shape[1], shape[2]]], 
			[type, [shape[0], shape[3], shape[2]]]
		]
	];

use <polyline_join.scad>
use <ptf/ptf_rotate.scad>

module draw(tris, radius) {
	for(tri = tris) {
		color(tri[0] == KITE ? "black" : "white")
	    polygon(tri[1] * radius);
	}

	for(tri = tris) {
	    polyline_join(tri[1] * radius)
		    circle(.1);
	}
}

$fn = 12;

radius = 7;

draw(tile_penrose2(5,
	[
		[KITE, [[0, 0], [1, 0], ptf_rotate([1, 0], 36)]]
	]
), radius);

translate([30, 0])
    draw(tile_penrose2(0), radius);

translate([60, 0])
    draw(tile_penrose2(1), radius);

translate([0, -30])
    draw(tile_penrose2(2), radius);

translate([30, -30])
    draw(tile_penrose2(3), radius);

translate([60, -30])
    draw(tile_penrose2(4), radius);