use <triangle/tri_incenter.scad>;

function convex_offset(vertices, d) = 
    let(
	    c = tri_incenter(vertices),
		leng_vertices = len(vertices)
	)
    [
	    for(i = [0:leng_vertices - 1]) 
	    let(
		    curr_p = vertices[i],
			next_p = vertices[(i + 1) % leng_vertices],
		    v1 = c - curr_p,
			v2 = next_p - curr_p,
			leng_v1 = norm(v1),
			leng_v2 = norm(v2),
			a = acos((v1 * v2) / (leng_v1 * leng_v2)),
			leng = -d / sin(a) 
		)
		v1 / leng_v1 * leng + curr_p
    ];