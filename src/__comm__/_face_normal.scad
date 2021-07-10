function _face_normal(points) =
	let(v = cross(points[2] - points[0], points[1] - points[0])) v / norm(v); 
	