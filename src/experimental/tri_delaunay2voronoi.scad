use <experimental/_impl/_tri_delaunay2voronoi_impl.scad>;
use <util/map/hashmap.scad>;
use <util/map/hashmap_keys.scad>;
use <util/map/hashmap_get.scad>;

function tri_delaunay2voronoi(d) = 
    let(
	    coords = delaunay_coords(d),
		coords_leng = len(coords),
		circles = delaunay_circles(d),
		tris = hashmap_keys(delaunay_triangles(d)),
        // circumcircle centers
        vertices = [for(t = tris) hashmap_get(circles, t)[0]],
		i_rts = [
			for(i = [0:len(tris) - 1])
			let(
				a = tris[i][0],
				b = tris[i][1],
				c = tris[i][2],
			    rt1 = [b, c, a],
			    rt2 = [c, a, b],
			    rt3 = [a, b, c]
			) 
			each [[a, rt1], [b, rt2], [c, rt3]]
		],
		connectedTris = [
		    for(i = [0:coords_leng - 1])
			[for(i_rt = i_rts) if(i_rt[0] == i) i_rt[1]]
		],
		triIndices = hashmap([
			for(i = [0:len(tris) - 1])
			let(
				a = tris[i][0],
				b = tris[i][1],
				c = tris[i][2],
			    rt1 = [b, c, a],
			    rt2 = [c, a, b],
			    rt3 = [a, b, c]
			) 
			each [[rt1, i], [rt2, i], [rt3, i]]
		]),
		cells = [
		    for(i = [4:coords_leng - 1])
			indicesOfCell(connectedTris[i], triIndices)
		]
    )
	[for(cell = cells) [for(i = cell) vertices[i]]];
