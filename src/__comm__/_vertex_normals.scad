
use <_face_normal.scad>;
use <../util/slice.scad>;
use <../util/sort.scad>;
use <../util/sum.scad>;

ascending = function(e1, e2) e1 - e2;

function connected_faces(leng_pts, faces) =
	let(cnt_faces = [for(i = [0:leng_pts - 1]) []])
	_connected_faces(faces, len(faces), leng_pts, cnt_faces);
	
function _connected_faces(faces, leng, leng_pts, cnt_faces, i = 0) = 
	i == leng ? cnt_faces :
	let(
		facei = sort(faces[i], by = ascending),
		n_cnt_faces = [
		    for(k = [0:leng_pts - 1])
            search([k], facei)[0] != [] ? [each cnt_faces[k], faces[i]] : cnt_faces[k]
		]
	)
	_connected_faces(faces, leng, leng_pts, n_cnt_faces, i + 1);
	
function _vertex_normals(points, faces) = 
    let(
	    leng_pts = len(points),
	    cnn_faces = connected_faces(leng_pts, faces)
	)
	[
		for(i = [0:leng_pts - 1])
		let(
			face_normals = [
				for(face = cnn_faces[i])
					_face_normal([for(i = face) points[i]])
			]
		)
		sum(face_normals) / len(face_normals)
	];