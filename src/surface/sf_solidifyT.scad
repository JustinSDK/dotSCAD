/**
* sf_solidifyT.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidifyT.html
*
**/ 

use <../util/set/hashset.scad>;
use <../util/set/hashset_has.scad>;
use <../util/set/hashset_add.scad>;
use <../util/set/hashset_del.scad>;
use <../util/set/hashset_elems.scad>;

module sf_solidifyT(points1, points2, triangles) {
    // triangles : counter-clockwise
    leng = len(points1);
	assert(leng == len(points2), "The length of points1 must equal to the length of points2");
		
	tris = [for(tri = triangles) [tri[2], tri[1], tri[0]]];

    hash = function(e) e[0] + e[1] * 31; 

	function de_pairs(tri_edges) = 
		let(
			leng = len(tri_edges),
			edges = hashset([tri_edges[0], tri_edges[1], tri_edges[2]], hash = hash, number_of_buckets = round(sqrt(leng)))
		)
		_de_pairs(tri_edges, leng, edges);
		
	function _de_pairs(tri_edges, leng, edges, i = 3) =
		i == leng ? hashset_elems(edges) :
		let(edge = tri_edges[i], pair = [edge[1], edge[0]])
		hashset_has(edges, pair, hash = hash) ? 
			_de_pairs(tri_edges, leng, hashset_del(edges, pair, hash = hash), i + 1) :
			_de_pairs(tri_edges, leng, hashset_add(edges, edge, hash = hash), i + 1);	
			
	tri_edges = [
		for(tri = tris)
		each [
			[tri[0], tri[1]],
			[tri[1], tri[2]],
			[tri[2], tri[0]]
		]
	];	
	
	side_faces = [
	    for(edge = de_pairs(tri_edges))
		each [
		    [edge[1] + leng, edge[1], edge[0]],
			[edge[0] + leng, edge[1] + leng, edge[0]]
		]
	];
	
	polyhedron(
        points = concat(points1, points2), 
        faces = concat(
            tris, 
            [for(tri = triangles) tri + [leng, leng, leng]],
            side_faces
        )
    );
}