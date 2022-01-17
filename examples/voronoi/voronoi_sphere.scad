use <voronoi/vrn_sphere.scad>;
use <polyline_join.scad>;
use <experimental/convex_center_p.scad>;
use <sweep.scad>;
use <fibonacci_lattice.scad>;

n = 60;
radius = 5;

// pts = fibonacci_lattice(n, radius);
pts = [
	for(i = [0:n]) 
	let(
		theta = rands(0, 360, 1)[0],
		phi = rands(15, 165, 1)[0],
		rs = radius * sin(phi)
	)
	[
		rs * cos(theta), 
		rs * sin(theta), 
		radius * cos(phi)
	]
];
	
region_hollow = false;
region_offset = 0.2;
region_height = 1;

voronoi_sphere(pts, region_hollow, region_offset, region_height);

module voronoi_sphere(pts, region_hollow, region_offset, region_height) {
	cells = vrn_sphere(pts);
	r = norm(pts[0]);

	for(i = [0:len(cells) - 1]) {
		cell = cells[i];
		cell_cp = convex_center_p(cell);
		cell_inner = [
			for(p = cell)
			let(
				v = cell_cp - p,
				uv = v / norm(v)
			)
			p + uv * region_offset
		];
		
		double_cell_cp = cell_cp / norm(cell_cp) * r * 2;
		cell2 = [
			for(p = cell)
			let(
				v = double_cell_cp - p,
				uv = v / norm(v)
			)
			p + uv * region_height
		];
		
		if(region_hollow) {
			cell2_cp = convex_center_p(cell2);
			cell2_inner = [
				for(p = cell2)
				let(
					v = cell2_cp - p,
					uv = v / norm(v)
				)
				p + uv * region_offset
			];
			
			sweep([concat(cell, cell_inner), concat(cell2, cell2_inner)], "HOLLOW");
		} else {
			sweep([cell, cell2]);
		}
		

		polyline_join(concat(cell, [cell[0]]))
			sphere(region_offset / 2, $fn = 4);
	}
}