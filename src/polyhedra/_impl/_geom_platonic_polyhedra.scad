function _tri_subdivide(points, detail) = 
   let(
        rows = detail + 1,
		dr = (points[2] - points[0]) / rows,
		dc = (points[1] - points[0]) / rows,
		pts = [
			for(ri = [0:rows])
			    for(ci = [0:rows - ri]) 
				    points[0] + ci * dc + ri * dr 
		],
		ri_base = [for(ri = 0, acc = 0; ri <= rows; ri = ri + 1, acc = acc + rows - ri + 2) acc],
		idx = function(ci, ri) ci + ri_base[ri],
		faces = [
			for(ri = [0:rows - 1])
			let(cols = rows - ri - 1)
				for(ci = [0:cols]) 
				each (ci == cols ? 
					[
						[idx(ci + 1, ri), idx(ci, ri + 1), idx(ci, ri)]
					] :
					[
						[idx(ci + 1, ri), idx(ci, ri + 1), idx(ci, ri)], 
						[idx(ci + 1, ri + 1), idx(ci, ri + 1), idx(ci + 1, ri)]
					]
				) 
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
			for(pts_faces = subdivided_all)
				for(p = pts_faces[0]) 
					p / norm(p) * radius
		],
		pts_number_per_tri = len(subdivided_all[0][0]),
		flatten_faces = [
			for(i = [0:len(subdivided_all) - 1])
			let(faces = subdivided_all[i][1])
				for(face = faces) 
					face + [i, i, i] * pts_number_per_tri
		]
	)   
	[flatten_points, flatten_faces];