/**
* sf_curve.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_curve.html
*
**/ 

use <_impl/_sf_square_surfaces.scad>
use <../util/unit_vector.scad>
use <sf_solidify.scad>

module sf_curve(levels, curve_path, thickness, depth, invert = false, convexity = 1) {
    rows = len(levels);
    columns = len(levels[0]);
    leng_curve_path = len(curve_path);

    assert(leng_curve_path > columns, "The length of `curve_path` must be greater than the column length of `levels`");
    
    to = leng_curve_path - 1;
    pts = (leng_curve_path + 1 == columns) ? curve_path :
        // resample 
        let(diff = leng_curve_path / columns)
        [
            for(i = [each [0:columns]] * diff) 
            let(idx = floor(i))
            curve_path[idx > to ? to : idx]
        ];

    function __ry_matrix(a) = 
        let(c = cos(a), s = sin(a))
        [
            [c, 0, -s],
            [0, 1,  0],
            [s, 0,  c]
        ];    
        
    m = __ry_matrix(-90);
    normal_vts = [for(i = [0:columns - 1]) unit_vector(pts[i + 1] - pts[i]) * m];
		
	dp = is_undef(depth) ? thickness / 2 : depth;
	surfaces = _sf_square_surfaces(levels, thickness, dp, invert);
	
    function _curve(s) = [
		for(y = [0:rows - 1])
        let(off = [0, y, 0], sy = s[y])
		[
			for(x = [0:columns - 1]) 
			let(p = (pts[x] + pts[x + 1]) / 2)
			p + off + normal_vts[x] *sy[x][2]
		]
	];
	
	sf_solidify(_curve(surfaces[0]), _curve(surfaces[1]), convexity = convexity);
}