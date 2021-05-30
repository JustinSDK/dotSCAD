/**
* sf_curve.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_curve.html
*
**/ 

use <_impl/_sf_square_surfaces.scad>;
use <sf_solidify.scad>;
use <ptf/ptf_rotate.scad>;

module sf_curve(levels, curve_path, thickness, depth, invert = false) {
    rows = len(levels);
    columns = len(levels[0]);
    leng_curve_path = len(curve_path);

    assert(leng_curve_path > columns, "The length of `curve_path` must be greater than the column length of `levels`");
    
    to = leng_curve_path - 1;
    pts = (leng_curve_path + 1 == columns) ? curve_path :
        // resample 
        let(diff = leng_curve_path / columns)
        [
            for(i = [0:columns]) 
            let(idx = floor(diff * i))
            curve_path[idx > to ? to : idx]
        ];

    normal_vts = [
		for(i = [0:columns - 1]) 
		let(v = pts[i + 1] - pts[i])
		ptf_rotate(v / norm(v), [0, -90, 0])
	];
		
	dp = is_undef(depth) ? thickness / 2 : depth;
	surfaces = _sf_square_surfaces(levels, thickness, dp, invert);
	
    function _curve(s) = [
		for(y = [0:rows - 1])
		[
			for(x = [0:columns - 1]) 
			let(p = (pts[x] + pts[x + 1]) / 2)
			p + [0, y, 0] + normal_vts[x] * s[y][x][2]
		]
	];
	
	sf_solidify(_curve(surfaces[0]), _curve(surfaces[1]));
}