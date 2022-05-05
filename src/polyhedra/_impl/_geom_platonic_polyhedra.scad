function _tri_subdivide_pts(points, radius, rows) = 
   let(
		p0 = points[0],
		basis = [points[2] - p0, points[1] - p0] / rows
   )
   [
		for(ri = [0:rows], ci = [0:rows - ri])
		let(p = p0 + [ri, ci] * basis)
		radius * p / norm(p)
   ];

function _tri_subdivide_faces(rows) = 
    let(
		ri_base = [for(ri = 0, row_2 = rows + 2; ri <= rows; ri = ri + 1) ri * row_2 - ri * (ri + 1) * 0.5]
    )
    [
		for(ri = [0:rows - 1], base_i = ri_base[ri], base_i1 = ri_base[ri + 1])
			let(cols = rows - ri - 1)
			for(ci = [0:cols]) 
			if(ci != cols)
				each [
					[ci + 1 + base_i, ci + base_i1, ci + base_i], 
					[ci + 1 + base_i1, ci + base_i1, ci + 1 + base_i]
				]
			else 
				[ci + 1 + base_i, ci + base_i1, ci + base_i]
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
			for(i = [0:len(faces) - 1], face = subdivided_faces)
			face + [i, i, i] * pts_number_per_tri
		]
	)   
	[subdivided_pts, flatten_faces];