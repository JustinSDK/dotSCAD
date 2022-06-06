use <convex_offset.scad>
use <__comm__/_vertex_normals.scad>
use <util/reverse.scad>

module wireframe(points, faces, deep, outer_thickness, inner_thickness = 0, vertex_normals = undef) {
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
	vx_normals = is_undef(vertex_normals) ? _vertex_normals(points, faces) : vertex_normals;
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
		convex_offset([for(i = face) points[i]], -outer_thickness)
	];

	face_inner_pts = [
		for(i = [0:leng_faces - 1])
		reverse([for(j = faces[i]) inner_pts[j]])
	];
	offset_face_inner_pts = [ 
		for(face = faces)
        inner_thickness == 0 ? [for(i = face) inner_pts[i]] :
		                       reverse(convex_offset([for(i = face) inner_pts[i]], -inner_thickness))
	];

	outer = hollow_faces(face_pts, offset_face_pts);
	inner = inner_thickness == 0 ? [[], []] : hollow_faces(face_inner_pts, offset_face_inner_pts);

	outer_inner_pts = concat(outer[0], inner[0]);
	leng_outer = len(outer[0]);
	outer_inner_faces = concat(outer[1], [
		for(face = inner[1])
		[for(i = face) leng_outer + i]
	]);

	// offset_face_pts
	offset_face_inner_pts2 = inner_thickness == 0 ? 
		offset_face_inner_pts :
		[ 
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

    if(deep > 0) {
	    polyhedron(all_points, all_faces);
	}
	else {
		polyhedron(all_points, [for(f = all_faces) reverse(f)]);
	}
}

/*
deep = 0.2;
thickness = 0.2;

points = [[-1, -1, 0], [-1, 1, 0], [0, 0, -1], [0, 0, 1], [1, -1, 0], [1, 1, 0], [1, 1, 1]];

faces = [[2, 1, 0], [3, 0, 1], [4, 2, 0], [4, 0, 3], [5, 1, 2], [5, 2, 4], [6, 3, 1], [6, 1, 5], [6, 4, 3], [6, 5, 4]];

wireframe(points, faces, deep, thickness);

cubePoints = [
  [ 0,  0,  0],  //0
  [ 2,  0,  0],  //1
  [ 2,  1.4, 0],  //2
  [ 0,  1.4, 0],  //3
  [ 0,  0,  1],  //4
  [ 2,  0,  1],  //5
  [ 2,  1.4, 1],  //6
  [ 0,  1.4, 1]]; //7
  
cubeFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left

translate([2, 0, 0])
    wireframe( cubePoints, cubeFaces, deep, thickness);*/