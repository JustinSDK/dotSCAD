use <convex_offset.scad>;
use <__comm__/_vertex_normals.scad>;
use <util/reverse.scad>;

module polyhedron_frame(points, faces, deep, thickness) {
	function hollow_face(pts, inner_pts) =
		let(
			leng = len(pts),
			indices = [
				for(i = [0:leng - 1])
				let(
					ni = (i + 1) % leng,
					j = i + leng,
					nj = ni + leng
				)
				[i, ni, nj, j]
			]
		) 
		[concat(pts, inner_pts), indices];
		
	function hollow_faces(face_pts, offset_face_pts) =
		let(
			leng_face_pts = len(face_pts),
			pts_faces = hollow_face(
			   face_pts[0], offset_face_pts[0]
			),
			pts = pts_faces[0],
			faces = pts_faces[1]
		)	
		_hollow_faces(face_pts, offset_face_pts, leng_face_pts, pts, faces);
		
	function _hollow_faces(face_pts, offset_face_pts, leng_face_pts, pts, faces, i = 1) = 
		i == leng_face_pts ? [pts, faces] :
		let(
			pts_faces = hollow_face(
			   face_pts[i], offset_face_pts[i]
			),
			npts = concat(pts, pts_faces[0]),
			nfaces = concat(faces, [
				for(indice = pts_faces[1])
				[for(i = indice) i + len(pts)]
					
			])
		)	
		_hollow_faces(face_pts, offset_face_pts, leng_face_pts, npts, nfaces, i + 1);

	function side(pts, inner_pts) =
		let(
			leng_pts = len(pts),
			indices = [
				for(i = [0:leng_pts - 1])
				let(
					ni = (i + 1) % leng_pts,
					j = i + leng_pts,
					nj = ni + leng_pts
				)
				[i, ni, nj, j]
			]
		) 
		[concat(pts, inner_pts), indices];

	function sides(pts1, pts2) = 
		let(
			leng_pts = len(pts1),
			pts_faces = side(
			   pts1[0], pts2[0]
			),
			pts = pts_faces[0],
			faces = pts_faces[1]
		)
		_sides(pts1, pts2, leng_pts, pts, faces);
		 
	function _sides(pts1, pts2, leng_pts, pts, faces, i = 1) = 
		i == leng_pts ? [pts, faces] :
		let(
			pts_faces = side(
			   pts1[i], pts2[i]
			),
			npts = concat(pts, pts_faces[0]),
			nfaces = concat(faces, [
				for(indice =  pts_faces[1])
				[for(i = indice) i + len(pts)]
					
			])
		)	
		_sides(pts1, pts2, leng_pts, npts, nfaces, i + 1);


	leng_faces = len(faces);
	vx_normals = _vertex_normals(points, faces);
	inner_pts = [
		for(i = [0:len(vx_normals) - 1])
		points[i] - vx_normals[i] * deep
	];

	face_pts = [
		for(i = [0:leng_faces - 1])
		[for(j = faces[i]) points[j]]
	];
	offset_face_pts = [ 
		for(face = faces)
		convex_offset([for(i = face) points[i]], -thickness)
	];

	face_inner_pts = [
		for(i = [0:leng_faces - 1])
		reverse([for(j = faces[i]) inner_pts[j]])
	];
	offset_face_inner_pts = [ 
		for(face = faces)
		reverse(convex_offset([for(i = face) inner_pts[i]], -thickness))
	];

	outer = hollow_faces(face_pts, offset_face_pts);
	inner = hollow_faces(face_inner_pts, offset_face_inner_pts);

	outer_inner_pts = concat(outer[0], inner[0]);
	leng_outer = len(outer[0]);
	outer_inner_faces = concat(outer[1], [
		for(face = outer[1])
		[for(i = face) leng_outer + i]
	]);

	// offset_face_pts
	offset_face_inner_pts2 = [ 
		for(face_pts = offset_face_inner_pts)
		reverse(face_pts)
	];

	hollow_sides = sides(offset_face_pts, offset_face_inner_pts2);

	leng_outer_inner = len(outer_inner_pts);

	all_points = concat(outer_inner_pts, hollow_sides[0]);
	all_faces = concat(outer_inner_faces, [
		for(face = hollow_sides[1])
		[for(i = face) leng_outer_inner + i]
	]);

	polyhedron(all_points, all_faces);
}

/*
use <__comm__/_convex_hull3.scad>;
use <polyhedron_hull.scad>;
use <experimental/convex_offset.scad>;
use <experimental/polyhedron_frame.scad>;

pts = [
    [1, 1, 1],
    [1, 1, 0],
    [-1, 1, 0],
    [-1, -1, 0],
    [1, -1, 0],
    [0, 0, 1],
    [0, 0, -1]
];

vts_faces = _convex_hull3(pts);

// ===

deep = 0.2;
thickness = 0.2;

points = vts_faces[0];
faces = vts_faces[1];

polyhedron_frame(points, faces, deep, thickness);

cubePoints = [
  [  0,  0,  0 ],  //0
  [ 10,  0,  0 ],  //1
  [ 10,  7,  0 ],  //2
  [  0,  7,  0 ],  //3
  [  0,  0,  5 ],  //4
  [ 10,  0,  5 ],  //5
  [ 10,  7,  5 ],  //6
  [  0,  7,  5 ]]; //7
  
cubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  
polyhedron_frame( cubePoints, cubeFaces, deep * 5, thickness * 5);*/