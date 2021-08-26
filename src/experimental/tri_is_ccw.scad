function tri_is_ccw(p1, p2, p3) =
    let(
		area = (p2[0] - p1[0]) * (p3[1] - p1[1]) - (p3[0] - p1[0]) * (p2[1] - p1[1]),
		_ = assert(area != 0, "points are collinear")
	)
	area > 0;