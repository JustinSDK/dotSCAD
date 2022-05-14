/**
* sf_solidifyT.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-sf_solidifyT.html
*
**/ 

module sf_solidifyT(points1, points2, triangles, convexity = 1) {
    // triangles : counter-clockwise
    leng = len(points1);
	assert(leng == len(points2), "The length of points1 must equal to the length of points2");
		
	tris = [for(tri = triangles) [tri[2], tri[1], tri[0]]];

	function de_pairs(tri_edges) = 
		let(
			leng = len(tri_edges),
			edges = [tri_edges[0], tri_edges[1], tri_edges[2]]
		)
		_de_pairs(tri_edges, leng, edges);
		
	function _de_pairs(tri_edges, leng, edges, i = 3) =
		i == leng ? edges :
		let(
			edge = tri_edges[i], 
			pair = [edge[1], edge[0]],
			indices = search([pair], edges, , num_returns_per_match=0)[0]
			
		)
		_de_pairs(
			tri_edges, 
			leng, 
			indices == [] ? 
			    [each edges, edge] : 
				[for(j = [0:len(edges) - 1]) if(search(j, indices) == []) edges[j]], 
			i + 1
		);
			
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
	
	off = [leng, leng, leng];
	polyhedron(
        points = concat(points1, points2), 
        faces = concat(
            tris, 
            [for(tri = triangles) tri + off],
            side_faces
        ),
		convexity = convexity
    );
}