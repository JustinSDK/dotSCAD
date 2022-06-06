/**
* tri_circumcenter.scad
*
* @copyright Justin Lin, 2021
* @license https://opensource.org/licenses/lgpl-3.0.html
*
* @see https://openhome.cc/eGossip/OpenSCAD/lib3x-tri_delaunay_shapes.html
*
**/

use <_impl/_tri_delaunay_comm_impl.scad>
use <../util/map/hashmap_keys.scad>

function tri_delaunay_shapes(d) = 
    let(coords = delaunay_coords(d))
	[
		for(tri = hashmap_keys(delaunay_triangles(d))) 
		if(tri[0] > 3 && tri[1] > 3 && tri[2] > 3)
		[coords[tri[2]], coords[tri[1]], coords[tri[0]]] // counter-clockwise
	];