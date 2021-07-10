use <triangle/tri_incenter.scad>;

function convex_offset(vertices, d) = 
    let(leng_vertices = len(vertices))
    [
	    for(i = [0:leng_vertices - 1]) 
	    let(
		    curr_p = vertices[i],
			next_p = vertices[(i + 1) % leng_vertices],
			pre_p = vertices[(i + leng_vertices - 1) % leng_vertices],
			c = tri_incenter([curr_p, next_p, pre_p]),
		    v1 = c - curr_p,
			v2 = next_p - curr_p,
			leng_v1 = norm(v1),
			leng_v2 = norm(v2),
			a = acos((v1 * v2) / (leng_v1 * leng_v2)),
			leng = -d / sin(a) 
		)
		v1 / leng_v1 * leng + curr_p
    ];