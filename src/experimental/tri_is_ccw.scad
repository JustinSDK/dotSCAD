function tri_is_ccw(shape_pts) =
    let(area = cross(shape_pts[1] - shape_pts[0], shape_pts[2] - shape_pts[0]))
    assert(area != 0, "points are collinear")
	area > 0;