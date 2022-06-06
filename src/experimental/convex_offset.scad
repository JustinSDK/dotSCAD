use <triangle/tri_incenter.scad>

function convex_offset(vertices, d) = 
    let(leng_vertices = len(vertices))
    [
	    for(i = [0:leng_vertices - 1]) 
	    let(
		    curr_p = vertices[i],
			next_p = vertices[(i + 1) % leng_vertices],
			pre_p = vertices[(i + leng_vertices - 1) % leng_vertices],
		    v1 = tri_incenter([curr_p, next_p, pre_p]) - curr_p,
			v2 = next_p - curr_p,
			s = -d / sqrt(v1 * v1 - (v1 * v2) ^ 2 / (v2 * v2))  
		)
		v1 * s + curr_p
    ];