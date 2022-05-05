function _tri_subdivide(points, detail) = 
   let(
        rows = detail + 1,
		p0 = points[0],
		basis = [points[2] - p0, points[1] - p0] / rows,
		pts = [
			for(ri = [0:rows], ci = [0:rows - ri])
			p0 + [ri, ci] * basis 
		],
		ri_base = [for(ri = 0, row_2 = rows + 2; ri <= rows; ri = ri + 1) ri * row_2 - ri * (ri + 1) * 0.5],
		faces = [
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
		]
   )
   [pts, faces];

function _subdivide_project(points, faces, radius, detail) = 
    detail == 0 ? [[for(p = points) p / norm(p) * radius], faces] :
    let(
	    subdivided_all = [
			for(face = faces)
			_tri_subdivide([for(i = face) points[i]], detail)
		],
		flatten_points = [
			for(pts_faces = subdivided_all, p = pts_faces[0])
			p / norm(p) * radius
		],
		pts_number_per_tri = len(subdivided_all[0][0]),
		flatten_faces = [
			for(i = [0:len(subdivided_all) - 1])
			let(faces = subdivided_all[i][1], off = [i, i, i] * pts_number_per_tri)
				for(face = faces) 
				face + off
		]
	)   
	[flatten_points, flatten_faces];