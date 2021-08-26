function tri_is_ccw(shape_pts) =
    let(
		p1 = shape_pts[0],
		p2 = shape_pts[1], 
		p3 = shape_pts[2],
		area = (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p3[0] - p1[0]) * (p2[1] - p1[1]),
		_ = assert(area != 0, "points are collinear")
	)
	area > 0;