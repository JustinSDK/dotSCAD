use <../../util/sum.scad>;

function _tri_subdivide(points, detail) = 
   let(
       rows = detail + 1,
		vc = points[2] - points[0],
		vr = points[1] - points[0],
		dr = vr / (detail + 1),
		dc = vc / (detail + 1),
		pts = [
			for(ri = [0:rows])
			let(cols = rows - ri)
			for(ci = [0:cols]) 
				points[0] + ci * dc + ri * dr 
		],
		pre_n = concat([0], [for(ri = [0:rows]) rows - ri + 1]),
		idx = function(ci, ri) ci + sum([for(i = [0:ri]) pre_n[i]]),
		faces = [
			for(ri = [0:rows - 1])
			let(cols = rows - ri - 1)
				for(ci = [0:cols]) 
				let(pre = 0)
				each (ci == cols ? 
					[
						[idx(ci, ri), idx(ci, ri + 1), idx(ci + 1, ri)]
					] :
					[
						[idx(ci, ri), idx(ci, ri + 1), idx(ci + 1, ri)], 
						[idx(ci + 1, ri), idx(ci, ri + 1), idx(ci + 1, ri + 1)]
					]
				) 
		]
   )
   [pts, faces];

function _subdivide_project(points, faces, radius, detail) = 
    let(
	    subdivided_all = [
			for(face = faces)
				_tri_subdivide([for(i = face) points[i]], detail)
		],
		pts_number_per_tri = len(subdivided_all[0][0]),
		flatten_points = [
			for(pts_faces = subdivided_all)
				for(p = pts_faces[0]) 
					p / norm(p) * radius
		],
		flatten_faces = [
			for(i = [0:len(subdivided_all) - 1])
			let(faces = subdivided_all[i][1])
				for(face = faces) 
					face + [i, i, i] * pts_number_per_tri
		]
	)   
	[flatten_points, flatten_faces];