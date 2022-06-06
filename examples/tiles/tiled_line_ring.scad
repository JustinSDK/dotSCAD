use <experimental/tile_truchet.scad>
use <polyline_join.scad>
use <polyhedra/icosahedron.scad>

radius = 15;
height = 10;
line_diameter = 2;
$fn = 4;

module tiled_line_ring(radius, height, line_diameter) {
    half_line_diameter = line_diameter / 2;
    size = [
	    round(2 * radius * PI / line_diameter), 
		round(height / line_diameter)
	];
    lines = [
		for(tile = tile_truchet(size)) 
		let(
			x = tile.x,
			y = tile.y,
			i = tile[2]
		)
		if(i <= 1)  [
			[x * half_line_diameter, y * line_diameter], 
			[(x + 1) * half_line_diameter, (y + 1) * line_diameter]
		] 
	    else [
			[(x + 1) * half_line_diameter, y * line_diameter],
			[x * half_line_diameter, (y + 1) * line_diameter]
		]  
    ];
            
	a = 360 / size[0];
    for(line = lines) {
	    pts = [
		    for(p = line) 
		        [radius * cos(a * p[0]), radius * sin(a * p[0]), p[1]]
		];
        polyline_join(pts) 
		    icosahedron(half_line_diameter);
    }
}

tiled_line_ring(radius, height, line_diameter);