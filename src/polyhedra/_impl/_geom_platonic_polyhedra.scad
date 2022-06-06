use <../../util/unit_vector.scad>

function _tri_subdivide_pts(points, radius, rows) = 
   let(
		p0 = points[0],
		basis = [points[2] - p0, points[1] - p0] / rows
   )
   [
		for(ri = [0:rows], ci = [0:rows - ri])
		radius * unit_vector(p0 + [ri, ci] * basis)
   ];

function _tri_subdivide_faces(rows) = 
    let(
		ri_base = [for(ri = 0, row_2 = rows + 2; ri <= rows; ri = ri + 1) ri * row_2 - ri * (ri + 1) * 0.5]
    )
    [
		for(ri = [0:rows - 1])
			let(cols = rows - ri - 1, base_i = ri_base[ri], base_i1 = ri_base[ri + 1])
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

function _subdivide_project(points, faces, radius, detail) = 
    detail == 0 ? [points * radius / norm(points[0]), faces] :
    let(
		rows = detail + 1,
	    subdivided_pts = [
			for(face = faces)
		    each _tri_subdivide_pts([for(i = face) points[i]], radius, rows)
		],
		pts_number_per_tri = (rows + 1) * (rows + 2) / 2,
	    subdivided_faces = _tri_subdivide_faces(rows),
		flatten_faces = [
			for(i = [0:pts_number_per_tri:(len(faces) - 1) * pts_number_per_tri], face = subdivided_faces)
			face + [i, i, i]
		]
	)   
	[subdivided_pts, flatten_faces];