/**
* tri_circumcenter.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay_voronoi.html
*
**/

use <_impl/_tri_delaunay_comm_impl.scad>
use <_impl/_tri_delaunay_voronoi_impl.scad>
use <../util/map/hashmap.scad>
use <../util/map/hashmap_keys.scad>
use <../util/map/hashmap_get.scad>
use <../util/reverse.scad>

function tri_delaunay_voronoi(d) = 
    let(
		_indices_hash = function(indices) indices[3],
	    coords = delaunay_coords(d),
		coords_leng = len(coords),
		circles = delaunay_circles(d),
		tris = hashmap_keys(delaunay_triangles(d)),
        // circumcircle centers
        vertices = [for(t = tris) hashmap_get(circles, t, hash = _indices_hash)[0]],
		i_rts = [
			for(tri = tris)
			let(a = tri[0], b = tri[1], c = tri[2]) 
			each [[a, [b, c, a]], [b, [c, a, b]], [c, [a, b, c]]]
		],
		connectedTris = [
		    for(i = [0:coords_leng - 1])
			[for(j = search(i, i_rts, num_returns_per_match=0)) i_rts[j][1]]
		],
		triIndices = hashmap([
			for(i = [0:len(tris) - 1])
			let(
				tri = tris[i],
				a = tri[0],
				b = tri[1],
				c = tri[2]
			) 
			each [[[b, c, a], i], [[c, a, b], i], [[a, b, c], i]]
		]),
		cells = [
		    for(i = [4:coords_leng - 1])
			indicesOfCell(connectedTris[i], triIndices) 
		]
    )
	[
		for(cell = cells) 
		// counter-clockwise
		[for(i = len(cell) - 1; i > -1; i = i - 1) vertices[cell[i]]] 
	];
