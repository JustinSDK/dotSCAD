function angle_between_ccw_2d(v1, v2) = 
    let(a = atan2(v1.x * v2.y - v1.y * v2.x, v1 * v2))
	a >= 0 ? a : a + 360;

function angle_between_ccw_3d(v1, v2) = 
    let(
	    dot = v1 * v2,
		lenSq1 = v1.x ^ 2 + v1.y ^ 2 + v1.z ^ 2,
		lenSq2 = v2.x ^ 2 + v2.y ^ 2 + v2.z ^ 2,
	    a = acos(dot / sqrt(lenSq1 * lenSq2))
	)
	a >= 0 ? a : a + 360;