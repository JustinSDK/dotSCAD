use <_impl/_sf_square_surfaces.scad>;
use <sf_solidify.scad>;
use <ptf/ptf_rotate.scad>;

module sf_curve(levels, points, thickness, depth, invert = false) {
    rows = len(levels);
    columns = len(levels[0]);

    normal_vts = [
		for(i = [0:columns - 1]) 
		let(v = points[i + 1] - points[i])
		ptf_rotate(v / norm(v), [0, -90, 0])
	];
		
	dp = is_undef(depth) ? thickness / 2 : depth;
	surfaces = _sf_square_surfaces(levels, thickness, dp, invert);
	
    function _curve(s) = [
		for(y = [0:rows - 1])
		[
			for(x = [0:columns - 1]) 
			let(p = points[x])
			[p[0], y, p[2]] + normal_vts[x] * s[y][x][2]
		]
	];

	
	sf_solidify(_curve(surfaces[0]), _curve(surfaces[1]));
}