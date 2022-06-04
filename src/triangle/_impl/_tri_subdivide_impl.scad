function _tri_subdivide_pts(points, n) = 
   let(
		p0 = points[0],
		basis = [points[2] - p0, points[1] - p0] / n,
        pts = [
		    for(ri = [0:n], ci = [0:n - ri])
		    p0 + [ri, ci] * basis
        ]
   )
   pts;
   
function _tri_subdivide_indices(n) = 
    let(
		ri_base = [for(ri = 0, row_2 = n + 2; ri <= n; ri = ri + 1) ri * row_2 - ri * (ri + 1) * 0.5]
    )
    [
		for(ri = [0:n - 1])
			let(cols = n - ri - 1, base_i = ri_base[ri], base_i1 = ri_base[ri + 1])
			for(ci = [0:cols]) 
			let(ci_base_i = ci + base_i, ci_base_i1 = ci + base_i1, ci_base_i_1 = ci_base_i + 1)
			if(ci != cols)
				each [
					[ci_base_i_1, ci_base_i1, ci_base_i], 
					[ci_base_i1 + 1, ci_base_i1, ci_base_i_1]
				]
			else 
				[ci_base_i_1, ci_base_i1, ci_base_i]
	];