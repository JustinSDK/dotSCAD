function angle_between_ccw_2d(v1, v2) = 
    let(a = atan2(v1[0] * v2[1] - v1[1] * v2[0], v1 * v2))
	a >= 0 ? a : a + 360;

function angle_between_ccw_3d(v1, v2) = 
    let(
	    dot = v1 * v2,
		lenSq1 = v1[0] ^ 2 + v1[1] ^ 2 + v1[2] ^ 2,
		lenSq2 = v2[0] ^ 2 + v2[1] ^ 2 + v2[2] ^ 2,
	    a = acos(dot / sqrt(lenSq1 * lenSq2))
	)
	a >= 0 ? a : a + 360;