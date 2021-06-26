use <util/set/hashset.scad>;
use <util/set/hashset_has.scad>;
use <util/set/hashset_add.scad>;
use <util/set/hashset_del.scad>;
use <util/set/hashset_elems.scad>;

module sf_solidify_tri(points1, points2, triangles) {
    // triangles : clockwise
    leng = len(points1);
	assert(leng == len(points2), "The length of points1 must equal to the length of points2");
		
	function de_pairs(tri_edges) = 
		let(
			leng = len(tri_edges),
			edges = hashset([tri_edges[0], tri_edges[1], tri_edges[2]], number_of_buckets = round(sqrt(leng)))
		)
		_de_pairs(tri_edges, leng, edges);
		
	function _de_pairs(tri_edges, leng, edges, i = 3) =
		i == leng ? hashset_elems(edges) :
		let(edge = tri_edges[i], pair = [edge[1], edge[0]])
		hashset_has(edges, pair) ? 
			_de_pairs(tri_edges, leng, hashset_del(edges, pair), i + 1) :
			_de_pairs(tri_edges, leng, hashset_add(edges, edge), i + 1);	
			
	tri_edges = [
		for(tri = triangles)
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
            triangles, 
            [for(tri = triangles) [tri[2], tri[1], tri[0]] + [leng, leng, leng]],
            side_faces
        )
    );
}

/*
use <triangle/tri_delaunay.scad>;
use <triangle/tri_delaunay_indices.scad>;
use <triangle/tri_delaunay_shapes.scad>;

use <surface/sf_solidify_tri.scad>;

points = [for(i = [0:50]) rands(-200, 200, 2)]; 

delaunay = tri_delaunay(points, ret = "DELAUNAY");

// count-clockwise (dotSCAD 2D polygon convention)
indices = tri_delaunay_indices(delaunay);
shapes = tri_delaunay_shapes(delaunay);


for(t = shapes) {
    offset(-1)
        polygon(t);
}

pts = [for(p = points) [p[0], p[1], rands(100, 150, 1)[0]]];
pts2 = [for(p = pts) [p[0], p[1], p[2] - 10]];

// triangles: clockwise (openscad 3D face convention)
sf_solidify_tri(pts, pts2, 
    triangles = [for(tri = indices) [tri[2], tri[1], tri[0]]]);	

*/