
use <_face_normal.scad>
use <../util/sum.scad>
use <../util/contains.scad>

function _vertex_normals(points, faces) = 
    let(cnn_indices_faces = [for(face = faces, i = face) [i, face]])
	[
		for(i = [0:len(points) - 1])
		let(
			indices = search(i, cnn_indices_faces, num_returns_per_match = 0),
			face_normals = [
				for(j = indices)
					_face_normal([for(k = cnn_indices_faces[j][1]) points[k]])
			]
		)
		sum(face_normals) / len(face_normals)
	];