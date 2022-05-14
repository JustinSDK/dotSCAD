
use <_face_normal.scad>;
use <../util/sum.scad>;
use <../util/contains.scad>;

function _vertex_normals(points, faces) = 
    let(
	    leng_pts = len(points),
		range = [0:leng_pts - 1],
	    cnn_indices_faces = [for(face = faces, i = face) [i, face]]
	)
	[
		for(i = [0:leng_pts - 1])
		let(
			indices = search(i, cnn_indices_faces, num_returns_per_match = 0),
			connected_faces = [for(j = indices) cnn_indices_faces[j][1]],
			face_normals = [
				for(face = connected_faces)
					_face_normal([for(k = face) points[k]])
			]
		)
		sum(face_normals) / len(face_normals)
	];