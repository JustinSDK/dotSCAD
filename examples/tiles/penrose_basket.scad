use <experimental/tile_penrose3.scad>;
use <experimental/ptf_c2sphere.scad>;
use <ptf/ptf_rotate.scad>;
use <hull_polyline3d.scad>;

radius = 10;
n = 5;
line_diameter = .5;
$fn = 3;
		
penrose_basket(radius, n, line_diameter);

module penrose_basket(radius, n, line_diameter) {
	cos36 = cos(36);
	sin36 = sin(36);

	obtuse = [
		[2 * cos36 ^ 2, 2 * cos36 * sin36], 
		[1, 0],
		[0, 0]
	];

	acute = [
		[4 * cos36 ^ 2 - 1, 0],
		[2 * cos36 ^ 2, 2 * cos36 * sin36],
		[1, 0]
	];

	tris = tile_penrose3(n, [
		for(i = [0:4])
			each [
				["OBTUSE", 
					[for(p = obtuse) ptf_rotate(p, i * 72)]
				],
				["ACUTE",
					[for(p = acute) ptf_rotate(p, i * 72)]
				]	
			]
	]);
	
	r = radius * 2 * cos36;
	for(t = tris) {
		hull_polyline3d(
		    [for(p = t[1] * radius) ptf_c2sphere(p, r)], 
			line_diameter
		);	
	}
}
